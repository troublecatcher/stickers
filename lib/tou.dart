import 'package:flutter/material.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(231, 231, 231, 1),
        centerTitle: false,
        title: const Text(
          'Terms of use',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
