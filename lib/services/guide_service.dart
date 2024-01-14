// TODO bikin guide service
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinacom_2024/models/guide_content.dart';

class GuideService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<List<GuideContent>?> getAllGuides() async {
    final docRef = db.collection("guides").withConverter(
        fromFirestore: GuideContent.fromFirestore,
        toFirestore: (GuideContent guide, options) => guide.toFirestore());

    final docSnap = await docRef.get();
    final guideList = docSnap.docs.map((e) => e.data()).toList();

    return guideList;
  }
}