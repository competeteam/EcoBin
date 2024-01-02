import 'package:flutter/material.dart';

class Classificator extends StatefulWidget {
  const Classificator({super.key});

  @override
  State<Classificator> createState() => _ClassificatorState();
}

class _ClassificatorState extends State<Classificator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classificator'),
      ),
      body: const Center(
        child: Text('Classificator'),
      ),
    );
  }
}