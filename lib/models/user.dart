import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

enum UserType { user, admin }

class UserModel implements Model {
  final DateTime deletedAt;
  final DateTime createdAt;
  final String uid;
  final String displayName;
  final String email;
  final String photoURL;
  final bool isEmailVerified;
  final bool isAnonymous;
  final UserType type;

  UserModel({
    required this.deletedAt,
    required this.createdAt,
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoURL,
    required this.isEmailVerified,
    required this.isAnonymous,
    required this.type,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot snapshot,
    SnapshotOptions? options,
  ) {
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

  @override
  Map<String, dynamic> toFirestore() {
    print(deletedAt.toString());

    return {
      "deletedAt": deletedAt.toString(),
      "createdAt": createdAt.toString(),
      "uid": uid,
      "displayName": displayName,
      "email": email,
      "photoURL": photoURL,
      "isEmailVerified": isEmailVerified,
      "isAnonymous": isAnonymous,
      "type": type.toString().split('.').last,
    };
  }
}
