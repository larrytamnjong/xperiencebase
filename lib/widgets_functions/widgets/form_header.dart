import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String heading;
  final String body;
  const FormHeader({
    super.key,
    required this.heading,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          heading,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          body,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 25.0,
        ),
      ],
    );
  }
}
