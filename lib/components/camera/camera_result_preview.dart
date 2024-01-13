import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraShootPreview extends StatefulWidget {
  final XFile file;

  const CameraShootPreview(this.file, {super.key});

  @override
  State<CameraShootPreview> createState() => _CameraShootPreviewState();
}

class _CameraShootPreviewState extends State<CameraShootPreview> {
  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);

    return Scaffold(
        backgroundColor: const Color(0xFF222222),
        body: Stack(children: [
          Center(
            child: Image.file(
              picture,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: MaterialButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    padding: const EdgeInsets.only(left: 9),
                    shape: const CircleBorder(),
                    height: 50,
                    minWidth: 50,
                    color: Colors.white,
                    child: const Icon(
                      IconData(
                        0xe093,
                        fontFamily: 'MaterialIcons',
                        matchTextDirection: true,
                      ),
                      size: 20,
                    )),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 30, left: 9, right: 9),
                child: Center(
                  child: MaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.all(20),
                          color: Colors.white,
                          child: const Text(
                            'Generate',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          )
                        ),
                ),
              )
            ],
          )
        ]));
  }
}
