import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

enum TrashCanType { organic, paper, plastic, glass, metal, eWaste }

class TrashCan implements Model {
  final Timestamp? lastUsed;
  final Timestamp? deletedAt;
  final Timestamp? createdAt;
  final String? xCoord;
  final String? yCoord;
  final TrashCanType? type;
  final String? createdBy;

  TrashCan(
      {this.lastUsed,
      this.deletedAt,
      this.createdAt,
      this.xCoord,
      this.yCoord,
      this.type,
      this.createdBy});

  factory TrashCan.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return TrashCan(
        lastUsed: data?['lastUsed'],
        deletedAt: data?['deletedAt'],
        createdAt: data?['createdAt'],
        xCoord: data?['xCoord'],
        yCoord: data?['yCoord'],
        type: data?['type'],
        createdBy: data?['createdBy']);
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      if (lastUsed != null) "lastUsed": lastUsed,
      if (deletedAt != null) "deletedAt": deletedAt,
      if (createdAt != null) "trashCanImage": createdAt,
      if (xCoord != null) "xCoord": xCoord,
      if (yCoord != null) "yCoord": yCoord,
      if (type != null) "type": type,
      if (createdBy != null) "createdBy": createdBy,
    };
  }
}
