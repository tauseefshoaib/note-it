// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const Center(child: const Text('Created with ❤ ️by Tauseef')),
    );
  }
}
