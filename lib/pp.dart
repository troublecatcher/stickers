import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(231, 231, 231, 1),
        centerTitle: false,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
