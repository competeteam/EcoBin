import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF222222),
        child: const Center(
          child: Text('Error'),
        ));
  }
}
