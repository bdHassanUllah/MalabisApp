import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth,);

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<User?> signInWithGoogle() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        // Mobile (Android/iOS) Google Sign-In
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) return null; // user cancelled

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        return userCredential.user;
      } else {
        // Web platform
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        final UserCredential userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
        return userCredential.user;
      }
    } catch (e) {
      print('Error during Google sign-in: $e');
      rethrow;
    }
  }

  


  Future<void> signOut() async {
    await GoogleSignIn().signOut(); // optional: to fully sign out Google
    await _firebaseAuth.signOut();
  }
}
