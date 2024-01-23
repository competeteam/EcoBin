import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF222222),
        child: const Center(
            child: SpinKitCircle(
          color: Color(0xFF75BC7B),
          size: 50.0,
        )));
  }
}
