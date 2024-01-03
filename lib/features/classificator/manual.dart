import 'package:dinacom_2024/components/classificator/manual_question_card.dart';
import 'package:dinacom_2024/components/classificator/manual_result_card.dart';
import 'package:flutter/material.dart';

class ManualClassificator extends StatefulWidget {
  const ManualClassificator({super.key});

  @override
  State<ManualClassificator> createState() => _ManualClassificatorState();
}

class _ManualClassificatorState extends State<ManualClassificator> {
  @override
  Widget build(BuildContext context) {
    return const ManualClassificatorResultCard();
  }
}
