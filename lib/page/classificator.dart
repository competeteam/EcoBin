import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
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
                SizedBox(
                  height: 5,
                ),
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
            const SizedBox(
              height: 49,
            ),
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF5B8A62),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(children: [
                        Positioned(
                          right: -28,
                          bottom: -45,
                          child: Container(
                            width: 290,
                            height: 260,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                'assets/images/Aset3removebgpreview1.png',
                              ),
                              fit: BoxFit.fitWidth,
                            )),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 26, top: 23, right: 70, bottom: 100),
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
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Answer questions to decide your waste classification.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 49,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF377EB5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(children: [
                        Positioned(
                          left: -35,
                          bottom: -54,
                          child: Container(
                            width: 236,
                            height: 222,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                'assets/images/Aset2removebgpreview1.png',
                              ),
                              fit: BoxFit.fitWidth,
                            )),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 70, top: 23, right: 26, bottom: 100),
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
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Take a photo of your waste. We will classify it.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
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
