import 'package:dqed1/pp_screen.dart';
import 'package:dqed1/tou_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

bool ableToCallShareWindow = true;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(right: 16, top: 20, left: 16),
        child: Column(
          children: [
            Builder(builder: (ctx) {
              return CupertinoButton(
                onPressed: () async {
                  if (ableToCallShareWindow) {
                    ableToCallShareWindow = false;
                    final box = ctx.findRenderObject() as RenderBox?;
                    await Share.shareWithResult(
                      'Check out these stickers! <appstorelink>',
                      sharePositionOrigin:
                          box!.localToGlobal(Offset.zero) & box.size,
                    ).whenComplete(() {
                      ableToCallShareWindow = true;
                    });
                  }
                },
                padding: EdgeInsets.zero,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: ListTile(
                    leading: const Icon(Icons.ios_share_rounded),
                    title: Text(
                      'Share with friends',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            Builder(builder: (context) {
              return CupertinoButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => const PrivacyPolicyScreen()));
                },
                padding: EdgeInsets.zero,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: Text(
                      'Privacy Policy',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            Builder(builder: (context) {
              return CupertinoButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => const TermsOfUseScreen()));
                },
                padding: EdgeInsets.zero,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: ListTile(
                    leading: const Icon(Icons.list_alt_rounded),
                    title: Text(
                      'Terms of Use',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              );
            }),
          ],
        ),
      )),
    );
  }
}
