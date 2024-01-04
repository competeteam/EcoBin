import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late List<CameraDescription> camera;
  late CameraController cameraController;
  bool _isCameraInitiated = false;

  @override
  void initState() {
    startCamera();
    super.initState();
  }

  void startCamera() async {
    camera = await availableCameras();

    cameraController = CameraController(
      camera[0],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isCameraInitiated = true;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // ignore: avoid_print
            print("access was denied");
            break;
          default:
            // ignore: avoid_print
            print('error');
            // ignore: avoid_print
            print(e.description);
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitiated) {
      // TODO: Make progress loading
      return const CircularProgressIndicator();
    }

    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          child: CameraPreview(cameraController),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top: 30, left: 20),
              child: MaterialButton(
                  onPressed: () {
                    GoRouter.of(context).go('/classificator');
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
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: const Icon(
                    IconData(0xf60b, fontFamily: 'MaterialIcons'),
                    size: 50,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
