import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class GuideContent {
  final String? title;
  final String? content;
  String? imagePath;
  final Timestamp createdAt;
  Color cardColor;

  GuideContent({
    this.title,
    this.content,
    this.imagePath,
    Timestamp? createdAt,
    this.cardColor = const Color.fromRGBO(55, 126, 181, 1),
  }) : createdAt = createdAt ?? Timestamp.now() {
    try {
      // TODO: Implement
    } catch (e) {
      imagePath = "assets/images/photo_unavailable_placeholder_basic.jpg";
    }
  }

  factory GuideContent.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return GuideContent(
        title: data?['title'],
        content: data?['content'],
        imagePath: data?['imagePath'],
        createdAt: data?['createdAt']);
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
