import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/user.dart';

class UserService {
  final CollectionReference db = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(
      {required createdAt,
      required String uid,
      required String displayName,
      required String email,
      String? photoURL,
      required bool isEmailVerified,
      required bool isAnonymous,
      UserType type = UserType.user}) async {
    try {
      final docRef = db
          .withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel user, options) => user.toFirestore())
          .doc(uid);

      UserModel user = UserModel(
          createdAt: createdAt,
          displayName: displayName,
          email: email,
          photoURL: photoURL ?? '',
          isEmailVerified: isEmailVerified,
          isAnonymous: isAnonymous,
          type: type);

      await docRef.set(user);
    } catch (e) {
      // TODO: Throw error
      print(e.toString());
    }
  }

  void deleteUser(String userID) async {
    final docRef = db.doc(userID).withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel user, options) => user.toFirestore());

    await docRef.update({"deletedAt": DateTime.now().toString()});
  }

  Future<UserModel?> getUserByUserID(String userID) async {
    final docRef = db.doc(userID).withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel user, options) => user.toFirestore());

    final docSnap = await docRef.get();

    final user = docSnap.data();

    if (user != null) {
      return user;
    } else {
      // TODO: Throw exception
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final docRef = db.where("email", isEqualTo: email).withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel user, options) => user.toFirestore());

    final docSnap = await docRef.get();

    final user = docSnap.docs[0].data();

    if (UserModel != null) {
      return user;
    } else {
      // TODO: Throw exception
    }
  }
}
