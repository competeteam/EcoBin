import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

enum UserType { user, admin }

class User implements Model {
  final Timestamp? deletedAt;
  final Timestamp? createdAt;
  final String? name;
  final String? email;
  final String? password;
  final UserType? type;

  User(
      {this.deletedAt,
      this.createdAt,
      this.name,
      this.email,
      this.password,
      this.type});

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return User(
        deletedAt: data?['deletedAt'],
        createdAt: data?['createdAt'],
        name: data?['name'],
        email: data?['email'],
        password: data?['password'],
        type: data?['type']);
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      if (deletedAt != null) "deletedAt": deletedAt!.seconds,
      if (createdAt != null) "createdAt": createdAt!.seconds,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (type != null) "type": type.toString().split('.').last,
    };
  }
}
