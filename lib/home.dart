import 'package:dinacom_2024/page/calculator.dart';
import 'package:dinacom_2024/page/classificator.dart';
import 'package:dinacom_2024/page/garbages.dart';
import 'package:dinacom_2024/page/guide.dart';
import 'package:dinacom_2024/page/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;
  final List<Widget> pages = [
    const Guide(),
    const Classificator(),
    const Garbages(),
    const Calculator(),
    const Profile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Guide();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.map),
        onPressed: () {},
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color.fromARGB(255, 51, 51, 51),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Guide();
                        currentPage = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          color: currentPage == 0
                              ? const Color.fromARGB(255, 117, 188, 123)
                              : const Color.fromARGB(255, 215, 215, 215),
                        ),
                        Text(
                          'Guide',
                          style: TextStyle(
                            fontSize: 10,
                            color: currentPage == 0
                                ? const Color.fromARGB(255, 117, 188, 123)
                                : const Color.fromARGB(255, 215, 215, 215),
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Classificator();
                        currentPage = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.grid_view_rounded,
                          color: currentPage == 1
                              ? const Color.fromARGB(255, 117, 188, 123)
                              : const Color.fromARGB(255, 215, 215, 215),
                        ),
                        Text(
                          'Classification',
                          style: TextStyle(
                            fontSize: 10,
                            color: currentPage == 1
                                ? const Color.fromARGB(255, 117, 188, 123)
                                : const Color.fromARGB(255, 215, 215, 215),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Calculator();
                        currentPage = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.auto_graph_outlined,
                          color: currentPage == 2
                              ? const Color.fromARGB(255, 117, 188, 123)
                              : const Color.fromARGB(255, 215, 215, 215),
                        ),
                        Text(
                          'Calculator',
                          style: TextStyle(
                            fontSize: 10,
                            color: currentPage == 2
                                ? const Color.fromARGB(255, 117, 188, 123)
                                : const Color.fromARGB(255, 215, 215, 215),
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,

                    onPressed: () {
                      setState(() {
                        currentScreen = const Profile();
                        currentPage = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentPage == 3
                              ? const Color.fromARGB(255, 117, 188, 123)
                              : const Color.fromARGB(255, 215, 215, 215),
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 10,
                            color: currentPage == 3
                                ? const Color.fromARGB(255, 117, 188, 123)
                                : const Color.fromARGB(255, 215, 215, 215),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
