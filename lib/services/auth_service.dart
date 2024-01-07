import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthService {
  final FirebaseAuth _authService = FirebaseAuth.instance;

  // create user object
  UserModel? _userFromFirebaseUser(User? user) {
    return user == null
        ? null
        : UserModel(
            uid: user.uid,
          );
  }

  // auth change user stream
  Stream<UserModel?> get user {
    return _authService
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  // sign in anonymously
  Future signInAnon() async {
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

// register with email & password

// sign out
  Future signOut() async {
    try {
      return await _authService.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
