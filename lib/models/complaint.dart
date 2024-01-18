import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/model.dart';

enum ComplaintType {
  full,
  damaged,
  unusualOdor,
  improperlyDorted,
  noLabel,
  notFound,
  others
}

class Complaint implements Model {
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

  Complaint(
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

  factory Complaint.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Complaint(
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

  @override
  Map<String, dynamic> toFirestore() {
    return {
      "deletedAt": deletedAt.toString(),
      "createdAt": createdAt.toString(),
      "uid": uid,
      "cid": cid,
      "content": content,
      "location": location,
      "isResolved": isResolved,
      "resolvedAt": resolvedAt.toString(),
      "resolvedBy": resolvedBy.toString(),
      "createdBy": createdBy,
      "type": type.toString(),
    };
  }
}
