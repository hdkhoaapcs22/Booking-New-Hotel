import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        child: const Text('Go back!'),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
    );
  }
}
