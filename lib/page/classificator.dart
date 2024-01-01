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
      backgroundColor: const Color(0xFF222222),
      body: Container(
          padding: const EdgeInsets.all(44),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Classificator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'Classify your waste, easily.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 49,),
              Column (
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed:() {
                          // ignore: avoid_print
                          print('Manual button Clicked');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5B8A62),
                          padding: const EdgeInsets.all(20),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Manual',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              'Answer questions to decide your waste classification.',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 49,),
                      ElevatedButton(
                        onPressed:() {
                          // ignore: avoid_print
                          print('Automatic button Clicked');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF377EB5),
                          padding: const EdgeInsets.all(20),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Automatic',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 35,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              'Take a photo of your waste. We’ll classify it.',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}