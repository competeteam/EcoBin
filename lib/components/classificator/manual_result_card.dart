import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ManualClassificatorResultCard extends StatefulWidget {
  const ManualClassificatorResultCard({super.key});

  @override
  State<ManualClassificatorResultCard> createState() =>
      _ManualClassificatorResultCardState();
}

class _ManualClassificatorResultCardState
    extends State<ManualClassificatorResultCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF222222),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Your waste is classified as...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    )),
                const SizedBox(
                  height: 50,
                ),
                // TODO: Result Image Classifier
                Image.asset(
                  'assets/images/Aset4removebgpreview1.png',
                  width: 200,
                  height: 250,
                ),
                const SizedBox(
                  height: 15,
                ),
                // TODO: Result Text Classifier
                const Text(
                  'Recyclable',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                MaterialButton(
                    onPressed: () {
                      GoRouter.of(context).go('/classificator');
                    },
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    color: const Color(0xFF5B8A62),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      'Okay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
