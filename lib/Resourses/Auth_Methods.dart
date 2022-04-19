import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reels/Models/UserModel.dart';
import 'package:reels/utils/StorageMethods.dart';

class Auth_Methods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUp(String email, String password, Uint8List file,
      String username) async {
    String res = "";

    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        String imageUrl =
            await StorageMethods().uploadTask(file, "profilePics", false);

        UserModel userModel = UserModel(
            userName: username,
            photoUrl: imageUrl,
            uid: _auth.currentUser!.uid);

        FirebaseFirestore.instance
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .set(userModel.toJson());

        res = "success";
      } else {
        res = "enter all field properly";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> login(String email, String password) async {
    String res = "some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = "succes";
      } else {
        res = "please enter email and password";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
