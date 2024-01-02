import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/complaint.dart';

class ComplaintService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addComplaint(
      {required String trashCanID,
      required String createdBy,
      required String complaintContent}) async {
    try {
      final docRef = db.collection("complaints").withConverter(
          fromFirestore: Complaint.fromFirestore,
          toFirestore: (Complaint complaint, options) =>
              complaint.toFirestore());

      Complaint complaint = Complaint(
          createdAt: Timestamp.now(),
          trashCanID: trashCanID,
          createdBy: createdBy,
          complaintContent: complaintContent);

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
