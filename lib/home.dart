import 'dart:io';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:dqed1/news_screen.dart';
import 'package:dqed1/settings_screen.dart';
import 'package:dqed1/stickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_stickers_plus/exceptions.dart';
import 'package:whatsapp_stickers_plus/whatsapp_stickers.dart';

import 'pp_screen.dart';
import 'tou_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Baseball',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Colors.blue, fontWeight: FontWeight.w900)),
              CupertinoButton(
                color: Colors.blue,
                onPressed: () => Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => const StickersScreen())),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/1.webp', width: 100, height: 100),
                    Text('Stickers',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              CupertinoButton(
                color: Colors.blue,
                onPressed: () => Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => const NewsScreen())),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.newspaper_rounded,
                      size: 100,
                    ),
                    Text('News', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              CupertinoButton(
                color: Colors.blue,
                onPressed: () => Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => const SettingsScreen())),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.settings_rounded,
                      size: 100,
                    ),
                    Text('Settings',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
