import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Model {
  factory Model.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toFirestore();
}
