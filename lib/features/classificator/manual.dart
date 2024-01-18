import 'package:dinacom_2024/components/classificator/question_card.dart';
import 'package:dinacom_2024/components/classificator/result_card.dart';
import 'package:flutter/material.dart';

class Question {
  final String text;
  final Question? yes;
  final Question? no;

  Question(this.text, {this.yes, this.no});
}

class ManualClassificator extends StatefulWidget {
  const ManualClassificator({super.key});

  @override
  State<ManualClassificator> createState() => _ManualClassificatorState();
}

class _ManualClassificatorState extends State<ManualClassificator> {
  late List<String> questions;
  late Question questionTree;
  late String result = '';

  @override
  void initState() {
    super.initState();

    questions = [
      'Is your waste made of organic matter or derived from living organism?',
      'Is your waste used for writing printing, or packaging?',
      'Is your waste liquid?',
      'Is your waste made of soft or mallable materials?',
      'Is your waste transparent or slightly transparent?',
      'Is your waste made of electronic components?',
    ];

    questionTree = Question(
      questions[0],
      yes: Question(
        questions[1],
        yes: Question('Paper'),
        no: Question('Organic'),
      ),
      no: Question(questions[2],
          yes: Question('Chemical'),
          no: Question(questions[3],
              yes: Question('Plastic'),
              no: Question(questions[4],
                  yes: Question('Glass'),
                  no: Question(
                    questions[5],
                    yes: Question('E Waste'),
                    no: Question('Metal'),
                  )))),
    );
  }

  void handleResponse(bool response) {
    Question? nextQuestion;
    if (response) {
      nextQuestion = questionTree.yes;
    } else {
      nextQuestion = questionTree.no;
    }

    print('This is next question ${nextQuestion?.text}');

    if (nextQuestion != null) {
      setState(() {
        questionTree = nextQuestion!;
      });
    } 

    if(questionTree.yes == null && questionTree.no == null) {
      setState(() {
        result = questionTree.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('This is the result $result');
    return result == ''
        ? ClassificatorQuestionCard(
            questionTree.text, handleResponse)
        : ClassificatorResultCard(result);
  }
}
