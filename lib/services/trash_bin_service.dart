import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/trash_bin_model.dart';

class TrashBinService {
  String? uid;
  String? tid;

  TrashBinService({this.uid, this.tid});

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('trash-bins');

  Future<void> addTrashBin({
    required DateTime createdAt,
    required String uid,
    required String tid,
    required String createdLocation,
    required String xCoord,
    required String yCoord,
    required List<TrashBinType> types,
    DateTime? deletedAt,
    String imagePath = '',
    int fillCount = 0,
    bool isFull = false,
  }) async {
    try {
      final docRef = collectionReference
          .withConverter(
              fromFirestore: TrashBinModel.fromFirestore,
              toFirestore: (TrashBinModel trashBin, options) =>
                  trashBin.toFirestore())
          .doc(tid);

      TrashBinModel trashBin = TrashBinModel(
          deletedAt: deletedAt ?? DateTime.utc(0),
          createdAt: createdAt,
          uid: uid,
          tid: tid,
          createdLocation: createdLocation,
          xCoord: xCoord,
          yCoord: yCoord,
          imagePath: imagePath,
          fillCount: fillCount,
          isFull: isFull,
          types: types);

      await docRef.set(trashBin);
    } catch (e) {
      // TODO: Throw error
    }
  }

  Future<void> updateTrashBin(
      {required String tid,
      required String imagePath,
      required String createdLocation,
      required List<TrashBinType> types}) async {
    try {
      final docRef = collectionReference.doc(tid).withConverter(
          fromFirestore: TrashBinModel.fromFirestore,
          toFirestore: (TrashBinModel trashBin, options) =>
              trashBin.toFirestore());

      await docRef.update({
        'imagePath': imagePath,
        'createdLocation': createdLocation,
        'types': types.map((type) => type.toString()).toList()
      });
    } catch (e) {
      // TODO: Throw error
    }
  }

  // TODO :Fix deleteTrashBin
  void deleteTrashCan(String trashCanID) async {
    final docRef = collectionReference.doc(trashCanID).withConverter(
        fromFirestore: TrashBinModel.fromFirestore,
        toFirestore: (TrashBinModel trashBin, options) =>
            trashBin.toFirestore());

    await docRef.update({"deletedAt": DateTime.now().toString()});
  }

  Future<List<TrashBinModel?>> get trashBinModels async {
    final docRef = collectionReference.where("uid", isEqualTo: uid);

    final docSnap = await docRef.get();

    List<TrashBinModel> trashBins = docSnap.docs.map((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

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
          types: List<TrashBinType>.from(
            data['types'].map((type) =>
                TrashBinType.values.firstWhere((e) => e.toString() == type)),
          ));
    }).toList();

    return trashBins;
  }

  Future<TrashBinModel?> get trashBinModel async {
    final docRef = collectionReference.doc(tid).withConverter(
        fromFirestore: TrashBinModel.fromFirestore,
        toFirestore: (TrashBinModel trashBin, options) =>
            trashBin.toFirestore());

    final docSnap = await docRef.get();

    return docSnap.data();
  }

  Future<List<TrashBinModel?>> getAllTrashCan() async {
    try {
      final querySnapshot = await collectionReference.get();

      List<TrashBinModel> trashBins = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

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
            types: List<TrashBinType>.from(
              data['types'].map((type) =>
                  TrashBinType.values.firstWhere((e) => e.toString() == type)),
            ));
      }).toList();

      return trashBins;
    } catch (e) {
      return List.empty();
    }
  }
// TODO: Get trash can by location
// TODO: Get trash can by type
// TODO: Get trash can by both
}
