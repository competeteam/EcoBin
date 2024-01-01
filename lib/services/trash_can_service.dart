import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/trash_can.dart';

class TrashCanService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addTrashCan(
      {required String xCoord,
      required String yCoord,
      required String createdBy,
      required TrashCanType type}) async {
    try {
      final docRef = db.collection("trash-cans").withConverter(
          fromFirestore: TrashCan.fromFirestore,
          toFirestore: (TrashCan trashCan, options) => trashCan.toFirestore());

      TrashCan trashCan = TrashCan(
        createdAt: Timestamp.now(),
        xCoord: xCoord,
        yCoord: yCoord,
        type: type,
      );

      DocumentReference<TrashCan> addedDocRef = await docRef.add(trashCan);

      return addedDocRef.id;
    } catch (e) {
      return "";
    }
  }

  void updateTrashCan(String trashCanID, Map<String, dynamic> data) async {
    final docRef = db.collection("trash-cans").doc(trashCanID).withConverter(
        fromFirestore: TrashCan.fromFirestore,
        toFirestore: (TrashCan trashCan, options) => trashCan.toFirestore());

    await docRef.update(data);
  }

  void use(String trashCanID) async {
    final docRef = db.collection("trash-cans").doc(trashCanID).withConverter(
        fromFirestore: TrashCan.fromFirestore,
        toFirestore: (TrashCan trashCan, options) => trashCan.toFirestore());

    await docRef.update({"lastUsed": Timestamp.now().seconds});
  }

  void deleteTrashCan(String trashCanID) async {
    final docRef = db.collection("trash-cans").doc(trashCanID).withConverter(
        fromFirestore: TrashCan.fromFirestore,
        toFirestore: (TrashCan trashCan, options) => trashCan.toFirestore());

    await docRef.update({"deletedAt": Timestamp.now().seconds});
  }

  Future<TrashCan?> getTrashCanByTrashCanID(String trashCanID) async {
    final docRef = db.collection("trash-cans").doc(trashCanID).withConverter(
        fromFirestore: TrashCan.fromFirestore,
        toFirestore: (TrashCan trashCan, options) => trashCan.toFirestore());

    final docSnap = await docRef.get();

    final trashCan = docSnap.data();

    if (trashCan != null) {
      return trashCan;
    } else {
      // TODO: Throw exception
    }
  }

// TODO: Get trash can by location
// TODO: Get trash can by type
// TODO: Get trash can by both
}
