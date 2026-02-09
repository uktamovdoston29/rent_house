import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static User? get currentUser => _auth.currentUser;
  static Future<User?> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(
        clientId:
            "730302124880-aii55pbrn1tjdk6hvha13ospj33pmbmm.apps.googleusercontent.com",
      );
      await _googleSignIn.signOut();
      final googleuser = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleuser.authentication;

      if (googleAuth.idToken == null) {
        return null;
      }
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error signing in with Google $e");
      }
      return null;
    }
  }
}
