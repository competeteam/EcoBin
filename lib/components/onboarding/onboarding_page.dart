import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  final String title;
  final String? logoPath;
  final String? subTitle;

  const OnboardingPage(
      {this.logoPath, this.subTitle, required this.title, super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: widget.logoPath != null? MainAxisAlignment.center : MainAxisAlignment.end,
      children: [
        if (widget.logoPath != null)
          Column(
            children: [
              const Text(
                'Welcome to',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Image.asset(
                widget.logoPath!,
                width: 256,
                height: 256,
              ),
            ],
          ),
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          textAlign: widget.logoPath != null ? TextAlign.center : TextAlign.left,
        ),
        if (widget.subTitle != null)
          const SizedBox(
            height: 15,
          ),
        if (widget.subTitle != null)
          Text(
            widget.subTitle!,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}
