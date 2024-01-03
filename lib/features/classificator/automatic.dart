import 'package:flutter/material.dart';

class AutomaticClassificator extends StatefulWidget {
  const AutomaticClassificator({super.key});

  @override
  State<AutomaticClassificator> createState() => _AutomaticClassificatorState();
}

class _AutomaticClassificatorState extends State<AutomaticClassificator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Automatic Classificator')),
    );
  }
}