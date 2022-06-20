import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khana/main.dart';
import 'package:khana/view/register.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      await FirebaseFirestore.instance.collection("users").doc(user.email).set({
        'email': user.email,
        // 'password': passwordController.text.trim(),
        'name': user.displayName,
        'phoneNumber': "",
        'photo': user.photoUrl,
      }).then((value) => Utils.showSnackBar("Logged In successfully", true));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      Utils.showSnackBar(e.toString(), false);
    }
    notifyListeners();
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future googleLogout() async {
    await googleSignIn.disconnect();
  }
}
