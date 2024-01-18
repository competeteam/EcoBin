import 'package:dinacom_2024/models/user_model.dart';
import 'package:dinacom_2024/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _authService = FirebaseAuth.instance;

  // create user object
  UserModel? _userFromFirebaseUser(User? user) {
    return user == null
        ? null
        : UserModel(
            deletedAt: DateTime.utc(0),
            createdAt: user.metadata.creationTime ?? DateTime.utc(0),
            uid: user.uid,
            displayName: user.displayName ?? '',
            email: user.email ?? '',
            photoURL: user.photoURL ?? '',
            city: '',
            province: '',
            totalEmissionReduced: 0,
            trashBinCount: 0,
            totalTrashBinFillCount: 0,
            isEmailVerified: user.emailVerified,
            isAnonymous: user.isAnonymous,
            type: UserType.user);
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
      // TODO: Throw error

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
      // TODO: Throw error
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

      await UserService(uid: user!.uid).addUser(
        deletedAt: DateTime.utc(0),
        createdAt: user.metadata.creationTime ?? DateTime.utc(0),
        uid: user.uid,
        displayName: name,
        email: user.email ?? '',
        photoURL: user.photoURL ?? '',
        isEmailVerified: user.emailVerified,
        isAnonymous: user.isAnonymous,
      );

      return _userFromFirebaseUser(user);
    } catch (e) {
      // TODO: Throw error

      return null;
    }
  }

  // sign out
  Future logOut() async {
    try {
      return await _authService.signOut();
    } catch (e) {
      // TODO: Throw error
    }
  }
}
