import 'dart:io';

import 'package:dinacom_2024/common/helper.dart';
import 'package:dinacom_2024/components/classificator/result_card.dart';
import 'package:dinacom_2024/components/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class AutomaticClassificator extends StatefulWidget {
  final File file;
  const AutomaticClassificator(this.file, {super.key});

  @override
  State<AutomaticClassificator> createState() => _AutomaticClassificatorState();
}

class _AutomaticClassificatorState extends State<AutomaticClassificator> {
  bool _loading = false;
  late List _output;

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
      classifyImage(widget.file);
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/models/model_unquant.tflite',
        labels: 'assets/models/labels.txt');
  }

  classifyImage(File image) async {
    setState(() {
      _loading = true;
    });
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _output = output!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !_loading
        ? ClassificatorResultCard(capitalize('${_output[0]['label']}'.replaceAll(RegExp(r'[0-9]'), ''), 1))
        : const Loading(),
      ),
    );
  }
}
