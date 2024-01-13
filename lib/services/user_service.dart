import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/user.dart';

class UserService {
  String? uid;

  UserService({this.uid});

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(
      {required DateTime deletedAt,
      required DateTime createdAt,
      required String uid,
      required String displayName,
      required String email,
      required String photoURL,
      required bool isEmailVerified,
      required bool isAnonymous,
      UserType type = UserType.user}) async {
    try {
      final docRef = collectionReference
          .withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel user, options) => user.toFirestore())
          .doc(uid);

      UserModel user = UserModel(
          deletedAt: deletedAt,
          createdAt: createdAt,
          uid: uid,
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
    final docRef = collectionReference.doc(userID).withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel user, options) => user.toFirestore());

    await docRef.update({"deletedAt": DateTime.now().toString()});
  }

  Future<UserModel?> getUserByUserID(String userID) async {
    final docRef = collectionReference.doc(userID).withConverter(
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
    final docRef = collectionReference
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

  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    return UserModel(
      deletedAt: DateTime.parse(data['deletedAt']),
      createdAt: DateTime.parse(data['createdAt']),
      uid: data['uid'],
      displayName: data['displayName'],
      email: data['email'],
      photoURL: data['photoURL'],
      isEmailVerified: data['isEmailVerified'],
      isAnonymous: data['isAnonymous'],
      type: UserType.values
          .firstWhere((e) => e.toString() == 'UserType.${data["type"]}'),
    );
  }

  Stream<UserModel> get userModel {
    return collectionReference
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) => _userDataFromSnapshot(snapshot));
  }
}
