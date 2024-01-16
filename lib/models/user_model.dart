import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

enum UserType { user, admin }

class UserModel {
  final DateTime deletedAt;
  final DateTime createdAt;
  final String uid;
  final String displayName;
  final String email;
  final String photoURL;
  final String city;
  final String province;
  final int trashBinCount;
  final int totalTrashBinFillCount;
  final int totalEmissionReduced;
  final double totalCarbonFootprint;
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
    required this.city,
    required this.province,
    required this.totalEmissionReduced,
    required this.totalCarbonFootprint,
    required this.trashBinCount,
    required this.totalTrashBinFillCount,
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
      city: data['city'],
      province: data['province'],
      trashBinCount: data['trashBinCount'],
      totalTrashBinFillCount: data['totalTrashBinFillCount'],
      totalEmissionReduced: data['totalEmissionReduced'],
      totalCarbonFootprint: data['totalCarbonFootprint'],
      isEmailVerified: data['isEmailVerified'],
      isAnonymous: data['isAnonymous'],
      type: UserType.values
          .firstWhere((e) => e.toString() == 'UserType.${data["type"]}'),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "deletedAt": deletedAt.toString(),
      "createdAt": createdAt.toString(),
      "uid": uid,
      "displayName": displayName,
      "email": email,
      "photoURL": photoURL,
      "city": city,
      "province": province,
      "trashBinCount": trashBinCount,
      "totalTrashBinFillCount": totalTrashBinFillCount,
      "totalEmissionReduced": totalEmissionReduced,
      "totalCarbonFootprint": totalCarbonFootprint,
      "isEmailVerified": isEmailVerified,
      "isAnonymous": isAnonymous,
      "type": type.toString().split('.').last,
    };
  }
}
