import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/complaint_model.dart';

class ComplaintService {
  String? uid;

  ComplaintService({this.uid});

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("complaints");

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addComplaint({
    required DateTime deletedAt,
    required DateTime createdAt,
    required String uid,
    required String cid,
    required String tid,
    required String content,
    required String location,
    bool isResolved = false,
    DateTime? resolvedAt,
    required ComplaintType type,
    required String createdBy,
    String resolvedBy = "",
  }) async {
    try {
      final docRef = db
          .collection("complaints")
          .withConverter(
              fromFirestore: ComplaintModel.fromFirestore,
              toFirestore: (ComplaintModel complaint, options) =>
                  complaint.toFirestore())
          .doc(cid);

      ComplaintModel complaint = ComplaintModel(
          deletedAt: deletedAt,
          createdAt: createdAt,
          uid: uid,
          cid: cid,
          tid: tid,
          content: content,
          location: location,
          isResolved: isResolved,
          resolvedAt: resolvedAt ?? DateTime.utc(0),
          type: type,
          createdBy: createdBy,
          resolvedBy: resolvedBy);

      await docRef.set(complaint);
    } catch (e) {
      // TODO: Implement
    }
  }

  void updateComplaint(String complaintID, Map<String, dynamic> data) async {
    final docRef = db.collection("complaints").doc(complaintID).withConverter(
        fromFirestore: ComplaintModel.fromFirestore,
        toFirestore: (ComplaintModel complaint, options) =>
            complaint.toFirestore());

    await docRef.update(data);
  }

  Future<void> resolveComplaint(
      {required String cid,
      required String uid,
      required DateTime resolvedAt}) async {
    try {
      final docRef = db.collection("complaints").doc(cid).withConverter(
          fromFirestore: ComplaintModel.fromFirestore,
          toFirestore: (ComplaintModel complaint, options) =>
              complaint.toFirestore());

      await docRef.update({
        "resolvedAt": resolvedAt.toString(),
        "resolvedBy": uid,
        "isResolved": true,
      });
    } catch (e) {
      // TODO: throw error
    }
  }

  void deleteComplaint(String complaintID) async {
    final docRef = db.collection("complaints").doc(complaintID).withConverter(
        fromFirestore: ComplaintModel.fromFirestore,
        toFirestore: (ComplaintModel complaint, options) =>
            complaint.toFirestore());

    await docRef.update({"deletedAt": Timestamp.now().seconds});
  }

  Future<List<ComplaintModel?>> get complaintModels async {
    final docRef = collectionReference.where("uid", isEqualTo: uid);

    final docSnap = await docRef.get();

    List<ComplaintModel> complaints = docSnap.docs.map((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

      return ComplaintModel(
          deletedAt: DateTime.parse(data['deletedAt']),
          createdAt: DateTime.parse(data['createdAt']),
          uid: data['uid'],
          cid: data['cid'],
          tid: data['tid'],
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

  Future<List<ComplaintModel?>> getComplaintByTid(String tid) async {
    try {
      final docRef = collectionReference.where("tid", isEqualTo: tid);

      final docSnap = await docRef.get();

      List<ComplaintModel> complaints = docSnap.docs.map((doc) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

        return ComplaintModel(
            deletedAt: DateTime.parse(data['deletedAt']),
            createdAt: DateTime.parse(data['createdAt']),
            uid: data['uid'],
            cid: data['cid'],
            tid: data['tid'],
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
    } catch (e) {
      return List.empty();
    }
  }

  Future<ComplaintModel?> getComplaintByComplaintID(String complaintID) async {
    final docRef = db.collection("complaints").doc(complaintID).withConverter(
        fromFirestore: ComplaintModel.fromFirestore,
        toFirestore: (ComplaintModel complaint, options) =>
            complaint.toFirestore());

    final docSnap = await docRef.get();

    final complaint = docSnap.data();

    if (complaint != null) {
      return complaint;
    } else {
      // TODO: Throw exception
      return null;
    }
  }
}
