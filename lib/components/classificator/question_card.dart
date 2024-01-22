import 'package:flutter/material.dart';

class ClassificatorQuestionCard extends StatefulWidget {
  final String questions;
  final Function(bool) handleResponse;

  const ClassificatorQuestionCard(this.questions, this.handleResponse,
      {super.key});

  @override
  State<ClassificatorQuestionCard> createState() =>
      _ClassificatorQuestionCardState();
}

class _ClassificatorQuestionCardState extends State<ClassificatorQuestionCard> {
  @override
  Widget build(BuildContext context) {
    String question = widget.questions;

    return Scaffold(
        backgroundColor: const Color(0xFF222222),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                question,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        widget.handleResponse(true);
                      },
                      child: const Text('Yes',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 25))),
                  const SizedBox(
                    height: 40,
                  ),
                  MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        // ignore: avoid_print
                        widget.handleResponse(false);
                      },
                      child: const Text('No',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 25))),
                ],
              )
            ]),
          ),
        ));
  }
}
