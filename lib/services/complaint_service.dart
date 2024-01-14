import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/complaint.dart';

class ComplaintService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addComplaint({
    required DateTime deletedAt,
    required DateTime createdAt,
    required String uid,
    required String cid,
    required String content,
    required String location,
    bool isResolved = false,
    DateTime? resolvedAt,
    required ComplaintType type,
    required String createdBy,
    String resolvedBy = "",
  }) async {
    try {
      final docRef = db.collection("complaints").withConverter(
          fromFirestore: Complaint.fromFirestore,
          toFirestore: (Complaint complaint, options) =>
              complaint.toFirestore());

      Complaint complaint = Complaint(
          deletedAt: deletedAt,
          createdAt: createdAt,
          uid: uid,
          cid: cid,
          content: content,
          location: location,
          isResolved: isResolved,
          resolvedAt: resolvedAt ?? DateTime.utc(0),
          type: type,
          createdBy: createdBy,
          resolvedBy: resolvedBy);

      DocumentReference<Complaint> addedDocRef = await docRef.add(complaint);

      return addedDocRef.id;
    } catch (e) {
      return "";
    }
  }

  void updateComplaint(String complaintID, Map<String, dynamic> data) async {
    final docRef = db.collection("complaints").doc(complaintID).withConverter(
        fromFirestore: Complaint.fromFirestore,
        toFirestore: (Complaint complaint, options) => complaint.toFirestore());

    await docRef.update(data);
  }

  void deleteComplaint(String complaintID) async {
    final docRef = db.collection("complaints").doc(complaintID).withConverter(
        fromFirestore: Complaint.fromFirestore,
        toFirestore: (Complaint complaint, options) => complaint.toFirestore());

    await docRef.update({"deletedAt": Timestamp.now().seconds});
  }

  Future<Complaint?> getComplaintByComplaintID(String complaintID) async {
    final docRef = db.collection("complaints").doc(complaintID).withConverter(
        fromFirestore: Complaint.fromFirestore,
        toFirestore: (Complaint complaint, options) => complaint.toFirestore());

    final docSnap = await docRef.get();

    final complaint = docSnap.data();

    if (complaint != null) {
      return complaint;
    } else {
      // TODO: Throw exception
    }
  }
}
