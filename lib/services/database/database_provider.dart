/*
database provider

it seprates the firestore data handling and UI of our app]
handles data to and from firebase
used to process data and display it in app

 */

import 'package:flutter/material.dart';
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
}
