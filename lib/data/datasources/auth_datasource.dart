import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user_entitiy.dart';
import '../models/user_model.dart';

const String clientId =
    '785258560356-f4b06i1vv02qk35aacr410riqtkhe4st.apps.googleusercontent.com';
const String serverClientId =
    'your-web-client-id.apps.googleusercontent.com';

class AuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserEntity> signInWithEmail(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserEntity(uid: credential.user!.uid, email: credential.user?.email);
  }

  Future<UserEntity> signUpWithEmail(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserEntity(uid: credential.user!.uid, email: credential.user?.email);
  }

  Future<void> signOut() => _auth.signOut();

  Future<UserEntity?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize(
        clientId: clientId,
        serverClientId: serverClientId,
      );

      final GoogleSignInAccount? account = await _googleSignIn.authenticate();
      if (account == null) {
        dev.log('Google Sign-In canceled');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await account.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final userDoc = await _firestore.collection("users").doc(user.uid).get();
        if (!userDoc.exists) {
          await _firestore
              .collection("users")
              .doc(user.uid)
              .set(UserModel.fromFirebase(user).toMap());
          dev.log('New user document created for UID: ${user.uid}');
        } else {
          dev.log('User document exists for UID: ${user.uid}');
        }
        return UserModel.fromFirebase(user);
      }

      return null;
    } catch (e) {
      dev.log('Google Sign-In Error: $e');
      return null;
    }
  }
}