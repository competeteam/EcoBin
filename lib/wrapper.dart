import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class Wrapper extends StatefulWidget {
   const Wrapper({
    required this.navigationShell,
    super.key,
  });
  final StatefulNavigationShell navigationShell;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int selectedIndex = 0;
  int currentPage = 0;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: currentPage == 2
              ? const Color.fromARGB(255, 212, 234, 214)
              : const Color.fromARGB(255, 215, 215, 215),
          onPressed: () async {
            
            await Permission.locationWhenInUse.isDenied.then((valueOfPermission)
            {
              if(valueOfPermission)
              {
                Permission.locationWhenInUse.request();
              }
            });

            setState(() {
              //currentScreen = const Garbages()
              
              _goBranch(2);
              currentPage = 2;
            });
          },
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 5,
                color: Color.fromARGB(255, 51, 51, 51),
              ),
              borderRadius: BorderRadius.circular(100)),
          child: Icon(
            Icons.room,
            size: 40,
            color: currentPage == 2
                ? const Color.fromARGB(255, 117, 188, 123)
                : const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 45, 45, 45),
        child: Container(
          height: 40,
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
                        //currentScreen = const Guide();
                        _goBranch(3);
                        currentPage = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          size:30,
                          color: currentPage == 3
                              ? const Color.fromARGB(255, 117, 188, 123)
                              : const Color.fromARGB(255, 215, 215, 215),
                        ),
                        Text(
                          'Guide',
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
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        //currentScreen = const Classificator();
                        _goBranch(1);
                        currentPage = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.grid_view_rounded,
                          size:30,
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
                        //currentScreen = const Calculator();
                        _goBranch(0);
                        currentPage = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.auto_graph_outlined,
                          size:30,
                          color: currentPage == 0
                              ? const Color.fromARGB(255, 117, 188, 123)
                              : const Color.fromARGB(255, 215, 215, 215),
                        ),
                        Text(
                          'Calculator',
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
                        //currentScreen = const Profile();
                        _goBranch(4);
                        currentPage = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size:30,
                          color: currentPage == 4
                              ? const Color.fromARGB(255, 117, 188, 123)
                              : const Color.fromARGB(255, 215, 215, 215),
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 10,
                            color: currentPage == 4
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
