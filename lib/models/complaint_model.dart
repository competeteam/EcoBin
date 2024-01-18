import 'package:cloud_firestore/cloud_firestore.dart';

enum ComplaintType {
  full,
  damaged,
  unusualOdor,
  improperlySorted,
  noLabel,
  notFound,
  others
}

class ComplaintModel {
  final DateTime deletedAt;
  final DateTime createdAt;
  final String uid;
  final String cid;
  final String content;
  final String location;
  final bool isResolved;
  final DateTime resolvedAt;
  final ComplaintType type;
  final String createdBy;
  final String resolvedBy;

  ComplaintModel(
      {required this.deletedAt,
      required this.createdAt,
      required this.uid ,
      required this.cid ,
      required this.content ,
      required this.location ,
      required this.isResolved ,
      required this.resolvedAt ,
      required this.type ,
      required this.createdBy ,
      required this.resolvedBy ,
      
      });

  factory ComplaintModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return ComplaintModel(
      deletedAt: data?['deletedAt'],
      createdAt: data?['createdAt'],
      uid: data?['uid'],
      cid: data?['cid'],
      content: data?['content'],
      location: data?['location'],
      isResolved: data?['isResolved'],
      resolvedAt: data?['resolvedAt'],
      type: data?['type'],
      createdBy: data?['createdBy'],
      resolvedBy: data?['resolvedBy'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "deletedAt": deletedAt.toString(),
      "createdAt": createdAt.toString(),
      "uid": uid,
      "cid": cid,
      "content": content,
      "location": location,
      "isResolved": isResolved,
      "resolvedAt": resolvedAt,
      "resolvedBy": resolvedBy.toString(),
      "createdBy": createdBy,
      "type": type.toString(),
    };
  }
}
