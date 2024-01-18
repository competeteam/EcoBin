import 'package:cloud_firestore/cloud_firestore.dart';

class GuideContent{
  final String? title;
  final String? content;
  final String? imagePath;
  final Timestamp createdAt;
  GuideContent({
    this.title,
    this.content,
    this.imagePath,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  factory GuideContent.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return GuideContent(
      title: data?['title'],
      content: data?['content'],
      imagePath: data?['imagePath'],
      createdAt: data?['createdAt']
    );
  }

  Map<String, dynamic> toFirestore() {
    if (title == null) {
      throw Exception("Guide content should have title");
    }
    if (content == null) {
      throw Exception("Guide content should have content");
    }


    return {
      "title": title,
      "content": content,
      "createdAt": createdAt,
      if (imagePath != null) "imagePath": imagePath,
    };
  }


}