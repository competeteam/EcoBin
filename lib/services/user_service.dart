import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/user.dart';

class UserService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addUser(
      {required String name,
      required String email,
      required String password,
      UserType type = UserType.user}) async {
    try {
      final docRef = db.collection("users").withConverter(
          fromFirestore: User.fromFirestore,
          toFirestore: (User user, options) => user.toFirestore());

      User user = User(
          createdAt: Timestamp.now(),
          name: name,
          email: email,
          password: password,
          type: type);

      DocumentReference<User> addedDocRef = await docRef.add(user);

      return addedDocRef.id;
    } catch (e) {
      return "";
    }
  }

  void updateUser(String userID, Map<String, dynamic> data) async {
    final docRef = db.collection("users").doc(userID).withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User user, options) => user.toFirestore());

    await docRef.update(data);
  }

  void deleteUser(String userID) async {
    final docRef = db.collection("users").doc(userID).withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User user, options) => user.toFirestore());

    await docRef.update({"deletedAt": Timestamp.now().seconds});
  }

  Future<User?> getUserByUserID(String userID) async {
    final docRef = db.collection("users").doc(userID).withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User user, options) => user.toFirestore());

    final docSnap = await docRef.get();

    final user = docSnap.data();

    if (user != null) {
      return user;
    } else {
      // TODO: Throw exception
    }
  }

  Future<User?> getUserByEmail(String email) async {
    final docRef = db
        .collection("users")
        .where("email", isEqualTo: email)
        .withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: (User user, options) => user.toFirestore());

    final docSnap = await docRef.get();

    final user = docSnap.docs[0].data();

    if (User != null) {
      return user;
    } else {
      // TODO: Throw exception
    }
  }
}
