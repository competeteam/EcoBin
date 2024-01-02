import 'package:flutter/material.dart';

class Garbages extends StatefulWidget {
  const Garbages({super.key});

  @override
  State<Garbages> createState() => _GarbagesState();
}

class _GarbagesState extends State<Garbages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garbages'),
      ),
      body: const Center(
        child: Text('Garbages'),
      ),
    );
  }
}