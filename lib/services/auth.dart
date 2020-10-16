//Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Google SignIn
import 'package:google_sign_in/google_sign_in.dart';

//Dart
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Get user now
  User get getUser => _auth.currentUser;

  //Get user if state change
  Stream<User> get user => _auth.authStateChanges();

  Future<UserCredential> anonLogin() async {
    UserCredential user = await _auth.signInAnonymously();
    updateUserData(user.user);
    return user;
  }

  Future<User> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      UserCredential result = await _auth.signInWithCredential(credential);

      User user = result.user;

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateUserData(User user) {
    DocumentReference reportRef = _db.collection('reports').doc(user.uid);

    return reportRef.set(
      {
        'uid': user.uid,
        'lastActivity': DateTime.now(),
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}