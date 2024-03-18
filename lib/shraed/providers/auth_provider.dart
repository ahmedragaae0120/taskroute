import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskroute/models/user_Model.dart';
import 'package:taskroute/shraed/remote/fire_store/fire_store_helper.dart';

class authProvider extends ChangeNotifier {
  User? firebaseauthUser;
  userModel? databaseUser;
  void setUser(
      {required User? newfirebaseauthUser,
      required userModel? newdatabaseUser}) {
    firebaseauthUser = newfirebaseauthUser;
    databaseUser = newdatabaseUser;
  }

  bool isfirebaseAuthUser() {
    if (FirebaseAuth.instance.currentUser == null) return false;
    firebaseauthUser = FirebaseAuth.instance.currentUser;
    return true;
  }

  Future<void> retriveDatabaseUserData() async {
    try {
      databaseUser = await fireStoreHelper.getUser(firebaseauthUser!.uid);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> logOut() async {
    firebaseauthUser = null;
    databaseUser = null;
    return await FirebaseAuth.instance.signOut();
  }
}
