import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'logo.dart';
import 'main.dart';
import 'pp.dart';
import 'tou.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            const Align(
              alignment: Alignment(0, -0.5),
              child: Logo(),
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  'Send stickers to any messenger with our app!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: CupertinoButton(
                      color: Colors.orange,
                      child: Text('Get started',
                          style: Theme.of(context).textTheme.bodyLarge),
                      onPressed: () async {
                        isFirstTime = false;
                        sharedPreferences.setBool('isFirstTime', isFirstTime!);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen()));
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const TermsOfUseScreen()));
                        },
                        child: const Text('Terms of use',
                            style: TextStyle(color: Colors.black))),
                    const Text('/'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const PrivacyPolicyScreen()));
                        },
                        child: const Text('Privacy Policy',
                            style: TextStyle(color: Colors.black))),
                  ],
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
