import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

enum UserType { user, admin }

class UserModel implements Model {
  final Timestamp? deletedAt;
  final Timestamp? createdAt;
  final String? uid;
  final String? displayName;
  final String? email;
  final String? password;
  final String? photoURL;

  final bool? isEmailVerified;
  final bool? isAnonymous;
  final UserType? type;

  UserModel({
    this.deletedAt,
    this.createdAt,
    this.uid,
    this.displayName,
    this.email,
    this.password,
    this.photoURL,
    this.isEmailVerified,
    this.isAnonymous,
    this.type,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return UserModel(
        deletedAt: data?['deletedAt'],
        createdAt: data?['createdAt'],
        uid: data?['uid'],
        displayName: data?['displayName'],
        email: data?['email'],
        password: data?['password'],
        photoURL: data?['photoURL'],
        isEmailVerified: data?['isEmailVerified'],
        isAnonymous: data?['isAnonymous'],
        type: data?['type']);
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      if (deletedAt != null) "deletedAt": deletedAt!.seconds,
      if (createdAt != null) "createdAt": createdAt!.seconds,
      if (uid != null) "uid": uid,
      if (displayName != null) "displayName": displayName,
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (photoURL != null) "photoURL": photoURL,
      if (isEmailVerified != null) "isEmailVerified": isEmailVerified,
      if (isAnonymous != null) "isAnonymous": isAnonymous,
      if (type != null) "type": type.toString().split('.').last,
    };
  }
}
