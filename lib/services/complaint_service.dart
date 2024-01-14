import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/complaint.dart';

class ComplaintService {
  String? uid;

  ComplaintService({this.uid});

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("complaints");

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

  Future<List<Complaint?>> get complaintModels async {
    final docRef = collectionReference.where("uid", isEqualTo: uid);

    final docSnap = await docRef.get();

    List<Complaint> complaints = docSnap.docs.map((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

      return Complaint(
          deletedAt: DateTime.parse(data['deletedAt']),
          createdAt: DateTime.parse(data['createdAt']),
          uid: data['uid'],
          cid: data['cid'],
          content: data['content'],
          location: data['location'],
          isResolved: data['isResolved'],
          resolvedAt: DateTime.parse(data['resolvedAt']),
          type: ComplaintType.values
              .firstWhere((e) => e.toString() == data['type']),
          createdBy: data['createdBy'],
          resolvedBy: data['resolvedBy']);
    }).toList();

    return complaints;
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
