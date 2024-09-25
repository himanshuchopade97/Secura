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

    notifyListeners();
  }

  //filter and return post according to given uid
  List<Post> filterUserPosts(String uid){
    return _allPosts.where((post) => post.uid == uid).toList();
  }
}
