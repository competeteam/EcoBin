import 'package:flutter/material.dart';

class ManualClassificatorQuestionCard extends StatefulWidget {
  const ManualClassificatorQuestionCard({super.key});

  @override
  State<ManualClassificatorQuestionCard> createState() =>
      _ManualClassificatorQuestionCardState();
}

class _ManualClassificatorQuestionCardState
    extends State<ManualClassificatorQuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF222222),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Is your waste made of plastic?",
                style: TextStyle(
                  fontSize: 40,
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
                        // ignore: avoid_print
                        print('yes');
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
                        print('no');
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
