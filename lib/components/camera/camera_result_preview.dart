import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraShootPreview extends StatefulWidget {
  final XFile file;

  const CameraShootPreview(this.file, {super.key});

  @override
  State<CameraShootPreview> createState() => _CameraShootPreviewState();
}

class _CameraShootPreviewState extends State<CameraShootPreview> {
  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);

    return Scaffold(
      body: Center(
        child: Image.file(picture),
      ),
    );
  }
}