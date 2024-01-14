import 'package:dinacom_2024/features/classificator/manual.dart';
import 'package:dinacom_2024/router/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Classificator extends StatefulWidget {
  const Classificator({super.key});

  @override
  State<Classificator> createState() => _ClassificatorState();
}

class _ClassificatorState extends State<Classificator> {
  void classicatorFeature(int featureNum) {
    if (featureNum == 1) {
      GoRouter.of(context).push('/classificator/manual');
    } else if (featureNum == 2) {
      GoRouter.of(context).go('/camera');
    } 
  }

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
                    GestureDetector(
                      onTap: () {
                        classicatorFeature(1);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF5B8A62),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(children: [
                          Positioned(
                            right: -90,
                            bottom: -60,
                            child: Container(
                              width: 300,
                              height: 250,
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
                            padding: const EdgeInsets.only(
                                left: 26, top: 23, right: 70, bottom: 100),
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
                    ),
                    const SizedBox(
                      height: 49,
                    ),
                    GestureDetector(
                      onTap: () {
                        classicatorFeature(2);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF377EB5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(children: [
                          Positioned(
                            left: -23,
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
                            padding: const EdgeInsets.only(
                                left: 120, top: 23, right: 26, bottom: 100),
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
                                  'Take a photo of your waste. We’ll classify it.',
                                  textAlign: TextAlign.right,
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
