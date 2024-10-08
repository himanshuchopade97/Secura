import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secura/models/post.dart';
import 'package:secura/models/user.dart';
import 'package:secura/services/auth/auth_service.dart';

//this class handles data from and to firebase

/*
need method for 
user profile
post msg
like
comment
acc stuff
follow
unfollow
search
 */

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  //save user info
  Future<void> saveUserInfoInFirebase(
      {required String name, required String email}) async {
    //get curr uid
    String uid = _auth.currentUser!.uid;

    //extract username from email
    String username = email.split('@')[0];

    //create user profile
    UserProfile user = UserProfile(
      uid: uid,
      name: name,
      email: email,
      username: username,
      bio: '',
    );

    //convert user into map
    final userMap = user.toMap();

    //save user
    await _db.collection("Users").doc(uid).set(userMap);
  }

  //get user info
  Future<UserProfile?> getUserFromFirebase(String uid) async {
    try {
      //retrieve user doc from firebase
      DocumentSnapshot userDoc = await _db.collection("Users").doc(uid).get();

      //convert doc to user profile
      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //update user bio
  Future<void> updateUserBioInFirebase(String bio) async {
    //get curr uid
    String uid = AuthService().getCurrentUid();

    try {
      await _db.collection("Users").doc(uid).update({'bio': bio});
    } catch (e) {
      print(e);
    }
  }

  //post msg
  Future<void> postMessageInFirebase(String message) async {
    try {
      String uid = _auth.currentUser!.uid;

      UserProfile? user = await getUserFromFirebase(uid);

      Post newPost = Post(
        id: '', //firebase will auto generate this
        uid: uid,
        name: user!.name,
        username: user.username,
        message: message,
        timestamp: Timestamp.now(),
        likeCount: 0,
        likedBy: [],
      );

      //convert post obj to map
      Map<String, dynamic> newPostMap = newPost.toMap();

      await _db.collection("Posts").add(newPostMap);
    } catch (e) {
      print(e);
    }
  }

  //delete msg
  Future<void> deletePostFromFirebase(String postId) async {
    try {
      await _db.collection("Posts").doc(postId).delete();
    } catch (e) {
      print(e);
    }
  }

  //get all posts
  Future<List<Post>> getAllPostsFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection("Posts")
          .orderBy('timestamp', descending: true)
          .get();

      //return a list of posts
      return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    } catch (e) {
      return [];
    }
  }

  //get individual post

  //like
  //like a post
  Future<void> toggleLikeInFirebase(String postId) async {
    try {
      //get curr uid
      String uid = _auth.currentUser!.uid;

      //go to doc for post
      DocumentReference postDoc = _db.collection("Posts").doc(postId);

      //execute like
      await _db.runTransaction((transaction) async {
        //get post data
        DocumentSnapshot postSnapshot = await transaction.get(postDoc);

        //get like of user
        List<String> likedBy = List<String>.from(postSnapshot['likedBy'] ?? []);

        //get like count
        int currentLikeCount = postSnapshot['likes'];

        //if user has not liked this post
        if (!likedBy.contains(uid)) {
          //add user to list
          likedBy.add(uid);

          //increment like count
          currentLikeCount++;
        }

        //if user already liked, then unlike
        else {
          //add user to list
          likedBy.remove(uid);

          //increment like count
          currentLikeCount--;
        }

        //update in firebase
        transaction.update(postDoc, {
          'likes': currentLikeCount,
          'likedBy': likedBy,
        });
      });
    } catch (e) {}
  }

  //comment

  //accoutn stuff

  //follow

  //search
}
