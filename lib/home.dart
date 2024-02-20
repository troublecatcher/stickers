import 'dart:io';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_stickers_plus/exceptions.dart';
import 'package:whatsapp_stickers_plus/whatsapp_stickers.dart';

import 'pp.dart';
import 'tou.dart';

bool ableToCallShareWindow = true;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tiger Stickers',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
              onPressed: () => showFlexibleBottomSheet(
                    bottomSheetBorderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                    minHeight: 0,
                    initHeight: 0.5,
                    maxHeight: 0.5,
                    context: context,
                    builder: _buildBottomSheet,
                    anchors: [0, 0.5],
                    isSafeArea: true,
                  ),
              icon: const Icon(Icons.settings_rounded))
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Color.fromRGBO(255, 165, 0, 0.5),
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ...List.generate(16, (index) {
                            return Builder(builder: (ctx) {
                              return GestureDetector(
                                  onTap: () async {
                                    if (ableToCallShareWindow) {
                                      ableToCallShareWindow = false;
                                      final box =
                                          ctx.findRenderObject() as RenderBox?;
                                      String copiedFilePath =
                                          await copyAssetToDevice(
                                              'assets/${index + 1}.webp');
                                      await Share.shareXFiles(
                                        [XFile(copiedFilePath)],
                                        sharePositionOrigin:
                                            box!.localToGlobal(Offset.zero) &
                                                box.size,
                                      ).whenComplete(() {
                                        deleteFile(copiedFilePath);
                                        ableToCallShareWindow = true;
                                      });
                                    }
                                  },
                                  child: Image.asset(
                                    'assets/${index + 1}.webp',
                                    height:
                                        MediaQuery.of(context).size.width / 4 -
                                            20,
                                    width:
                                        MediaQuery.of(context).size.width / 4 -
                                            20,
                                  ));
                            });
                          }),
                          Container(
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              leading: const Icon(Icons.info_outline_rounded),
                              title: Text(
                                'Save to Photos, Notes or Files and drag onto the chat to drop as sticker',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text('or', style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 10),
                      FittedBox(
                        child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.orange,
                            onPressed: () => uploadStickers(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/whatsapp.svg'),
                                Text('Import to Whatsapp',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.white)),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> copyAssetToDevice(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    final String tempPath = (await getTemporaryDirectory()).path;
    final String fileName = path.basename(assetPath);
    final File file = File('$tempPath/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future<void> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error while deleting file: $e');
    }
  }

  Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return Material(
      child: ListView(
        controller: scrollController,
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 16, top: 20, left: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text('Settings',
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 30),
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
                          color: Colors.orangeAccent,
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
                          MaterialPageRoute(
                              builder: (_) => const PrivacyPolicyScreen()));
                    },
                    padding: EdgeInsets.zero,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.orangeAccent,
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
                          MaterialPageRoute(
                              builder: (_) => const TermsOfUseScreen()));
                    },
                    padding: EdgeInsets.zero,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.orangeAccent,
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
          ))
        ],
      ),
    );
  }

  uploadStickers() async {
    const stickerAssets = {
      'assets/1.webp': ['😀'],
      'assets/2.webp': ['😃'],
      'assets/3.webp': ['😄'],
      'assets/4.webp': ['😁'],
      'assets/5.webp': ['😆'],
      'assets/6.webp': ['🥹'],
      'assets/7.webp': ['😅'],
      'assets/8.webp': ['😂'],
      'assets/9.webp': ['🤣'],
      'assets/10.webp': ['🥲'],
      'assets/11.webp': ['😌'],
      'assets/12.webp': ['😊'],
      'assets/13.webp': ['😇'],
      'assets/14.webp': ['🙂'],
      'assets/15.webp': ['🙃'],
      'assets/16.webp': ['😉'],
    };

    var stickerPack = WhatsappStickers(
      identifier: 'lionsTeamWhatsAppStickers',
      name: 'Tiger Stickers',
      publisher: 'Lion\'s Team Stickers',
      trayImageFileName: WhatsappStickerImage.fromAsset('assets/tray.png'),
      publisherWebsite: '',
      privacyPolicyWebsite: '',
      licenseAgreementWebsite: '',
    );

    stickerAssets.forEach((sticker, emojis) {
      stickerPack.addSticker(WhatsappStickerImage.fromAsset(sticker), emojis);
    });

    try {
      await stickerPack.sendToWhatsApp();
    } on WhatsappStickersException catch (e) {
      print(e.cause);
    }
  }
}
