import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/user_model.dart';

class UserService {
  String? uid;

  UserService({this.uid});

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(
      {required DateTime createdAt,
      required String uid,
      required String displayName,
      required String email,
      required bool isEmailVerified,
      required bool isAnonymous,
      DateTime? deletedAt,
      String photoURL = '',
      String city = '',
      String province = '',
      int totalEmissionReduced = 0,
      int trashBinCount = 0,
      int totalTrashBinFillCount = 0,
      UserType type = UserType.user}) async {
    try {
      final docRef = collectionReference
          .withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel user, options) => user.toFirestore())
          .doc(uid);

      UserModel user = UserModel(
          deletedAt: deletedAt ?? DateTime.utc(0),
          createdAt: createdAt,
          uid: uid,
          displayName: displayName,
          email: email,
          photoURL: photoURL,
          city: city,
          province: province,
          trashBinCount: trashBinCount,
          totalTrashBinFillCount: totalTrashBinFillCount,
          totalEmissionReduced: totalEmissionReduced,
          isEmailVerified: isEmailVerified,
          isAnonymous: isAnonymous,
          type: type);

      await docRef.set(user);
    } catch (e) {
      // TODO: Throw error
      print(e.toString());
    }
  }

  Future<void> updateUser(
      {required String uid,
      required String displayName,
      required String city,
      required String province}) async {
    try {
      final docRef = collectionReference.doc(uid).withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, options) => user.toFirestore());

      await docRef.update({
        "displayName": displayName,
        "city": city,
        "province": province,
      });
    } catch (e) {
      // TODO: throw error
      print(e.toString());
    }
  }

  // TODO: Fix deleteUser
  void deleteUser(String userID) async {
    final docRef = collectionReference.doc(userID).withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel user, options) => user.toFirestore());

    await docRef.update({"deletedAt": DateTime.now().toString()});
  }

  Future<UserModel?> get userModel async {
    final docRef = collectionReference.doc(uid).withConverter(
        fromFirestore: UserModel.fromFirestore,
        toFirestore: (UserModel user, options) => user.toFirestore());

    final docSnap = await docRef.get();

    return docSnap.data();
  }
}
