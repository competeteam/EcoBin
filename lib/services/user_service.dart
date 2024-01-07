import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/user.dart';

class UserService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addUser(
      {required String uid,
      required String displayName,
      required String email,
      required String password,
      String? photoURL,
      required bool isEmailVerified,
      required bool isAnonymous,
      UserType type = UserType.user}) async {
    try {
      final docRef = db.collection("users").withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, options) => user.toFirestore());

      UserModel user = UserModel(
          createdAt: Timestamp.now(),
          uid: uid,
          displayName: displayName,
          email: email,
          password: password,
          photoURL: photoURL ?? '',
          isEmailVerified: isEmailVerified,
          isAnonymous: isAnonymous,
          type: type);

      DocumentReference<UserModel> addedDocRef = await docRef.add(user);

      return addedDocRef.id;
    } catch (e) {
      return "";
    }
  }

  void updateUser(String userID, Map<String, dynamic> data) async {
    final docRef = db.collection("users").doc(userID).withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel user, options) => user.toFirestore());

    await docRef.update(data);
  }

  void deleteUser(String userID) async {
    final docRef = db.collection("users").doc(userID).withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel user, options) => user.toFirestore());

    await docRef.update({"deletedAt": Timestamp.now().seconds});
  }

  Future<UserModel?> getUserByUserID(String userID) async {
    final docRef = db.collection("users").doc(userID).withConverter(
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
    final docRef = db
        .collection("users")
        .where("email", isEqualTo: email)
        .withConverter(
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
