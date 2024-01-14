import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

enum TrashBinType { organic, paper, chemical, plastic, glass, metal, eWaste }

class TrashBinModel {
  final DateTime deletedAt;
  final DateTime createdAt;
  final String uid;
  final String tid;
  final String createdLocation;
  final String xCoord;
  final String yCoord;
  final String imagePath;
  final int fillCount;
  final bool isFull;
  final List<TrashBinType> types;

  TrashBinModel({
    required this.deletedAt,
    required this.createdAt,
    required this.uid,
    required this.tid,
    required this.createdLocation,
    required this.xCoord,
    required this.yCoord,
    required this.imagePath,
    required this.fillCount,
    required this.isFull,
    required this.types,
  });

  factory TrashBinModel.fromFirestore(
      DocumentSnapshot snapshot, SnapshotOptions? options) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    return TrashBinModel(
      deletedAt: DateTime.parse(data['deletedAt']),
      createdAt: DateTime.parse(data['createdAt']),
      uid: data['uid'],
      tid: data['tid'],
      createdLocation: data['createdLocation'],
      xCoord: data['xCoord'],
      yCoord: data['yCoord'],
      imagePath: data['imagePath'],
      fillCount: data['fillCount'],
      isFull: data['isFull'],
      types: data['types'].map((type) => TrashBinType.values
          .firstWhere((e) => e.toString() == 'TrashBinType.$type')),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      "deletedAt": deletedAt.toString(),
      "createdAt": createdAt.toString(),
      "uid": uid,
      "tid": tid,
      "createdLocation": createdLocation,
      "xCoord": xCoord,
      "yCoord": yCoord,
      "imagePath": imagePath,
      "fillCount": fillCount,
      "isFull": isFull,
      "types": types.map((type) => type.toString()),
    };
  }
}
