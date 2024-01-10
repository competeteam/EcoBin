import 'package:dinacom_2024/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthService {
  final FirebaseAuth _authService = FirebaseAuth.instance;

  // create user object
  UserModel? _userFromFirebaseUser(User? user) {
    return user == null
        ? null
        : UserModel(
            createdAt: user.metadata.creationTime,
            uid: user.uid,
            displayName: user.displayName,
            email: user.email,
            isEmailVerified: user.emailVerified,
            isAnonymous: user.isAnonymous,
          );
  }

  // auth change user stream
  Stream<UserModel?> get user {
    return _authService
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  // sign in anonymously
  Future logInAnon() async {
    try {
      UserCredential credential = await _authService.signInAnonymously();

      User? user = credential.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  // sign in with email & password
  Future logInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _authService.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = credential.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential credential = await _authService
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = credential.user;

      await UserService().addUser(
        createdAt: user!.metadata.creationTime,
        uid: user!.uid,
        displayName: user.displayName ?? '',
        email: user.email ?? '',
        isEmailVerified: user.emailVerified,
        isAnonymous: user.isAnonymous,
      );

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  // sign out
  Future logOut() async {
    try {
      return await _authService.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
