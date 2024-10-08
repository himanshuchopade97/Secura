// ignore_for_file: unused_field

/*
database provider

it seprates the firestore data handling and UI of our app]
handles data to and from firebase
used to process data and display it in app

 */

import 'package:flutter/material.dart';
import 'package:secura/models/post.dart';
import 'package:secura/models/user.dart';
import 'package:secura/services/auth/auth_service.dart';
import 'package:secura/services/database/database_service.dart';

class DatabaseProvider extends ChangeNotifier {
  //services

  final _auth = AuthService();
  final _db = DatabaseService();

  //user profile
  Future<UserProfile?> userProfile(String uid) => _db.getUserFromFirebase(uid);

  Future<void> updateBio(String bio) => _db.updateUserBioInFirebase(bio);

  //local list of posts
  List<Post> _allPosts = [];

  //get post
  List<Post> get allPosts => _allPosts;

  //post msg
  Future<void> postMessage(String message) async {
    await _db.postMessageInFirebase(message);

    await loadAllPosts();
  }

  //fetch all posts
  Future<void> loadAllPosts() async {
    final allPosts = await _db.getAllPostsFromFirebase();

    _allPosts = allPosts; //update local list

    //initialize local like data
    initializeLikeMap();

    notifyListeners();
  }

  //filter and return post according to given uid
  List<Post> filterUserPosts(String uid) {
    return _allPosts.where((post) => post.uid == uid).toList();
  }

  //delete post
  Future<void> deletePost(String postId) async {
    //delete from firebase
    await _db.deletePostFromFirebase(postId);

    //reload data
    await loadAllPosts();
  }

  /*
  LIKES
   */

  Map<String, int> _likeCounts = {
    //for each post id
  };

  //local list to track post by current user
  List<String> _likedPosts = [];

  //does the curr user like the post
  bool isPostLikedByCurrentUser (String postId) => _likedPosts.contains(postId);

  //get like count of a post
  int getLikeCount(String postId) => _likeCounts[postId]!;

  //initialize like map locally
  void initializeLikeMap() {
    //get current uid
    final currentUserID = _auth.getCurrentUid();

    //for each post get like data
    for (var post in _allPosts) {
      //update like count map
      _likeCounts[post.id] == post.likeCount;

      //if the current user already liked the post
      if (post.likedBy.contains(currentUserID)) {
        //add this post id to local list of liked post
        _likedPosts.add(post.id);
      }
    }
  }

  //toggle like
  Future<void> toggleLike(String postId) async {
    //we first update local value so ui is fast and responsive
    //revert back if anything goes wrong while writing in database

    //store original value in case it fails
    final likePostsOriginal = _likedPosts;
    final likeCountsOriginal = _likeCounts;

    //perform like/unlike
    if (_likedPosts.contains(postId)) {
      _likedPosts.remove(postId);
      _likeCounts[postId] = (_likeCounts[postId] ?? 0) - 1;
    } else {
      _likedPosts.add(postId);
      _likeCounts[postId] = (_likeCounts[postId] ?? 0) + 1;
    }

    //update ui locally

    //update in database
  }
}
