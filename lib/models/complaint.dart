import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/model.dart';

class Complaint implements Model {
  final Timestamp? deletedAt;
  final Timestamp? createdAt;
  final String? trashCanID;
  final String? createdBy;
  final String? complaintContent;

  Complaint(
      {this.deletedAt,
      this.createdAt,
      this.trashCanID,
      this.createdBy,
      this.complaintContent});

  factory Complaint.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Complaint(
      deletedAt: data?['deletedAt'],
      createdAt: data?['createdAt'],
      trashCanID: data?['trashCanID'],
      createdBy: data?['createdBy'],
      complaintContent: data?['complaintContent'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      if (deletedAt != null) "deletedAt": deletedAt,
      if (createdAt != null) "createdAt": createdAt,
      if (trashCanID != null) "trashCanID": trashCanID,
      if (createdBy != null) "createdBy": createdBy,
      if (complaintContent != null) "complaintContent": complaintContent,
    };
  }
}
