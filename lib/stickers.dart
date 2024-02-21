import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_stickers_plus/exceptions.dart';
import 'package:whatsapp_stickers_plus/whatsapp_stickers.dart';

bool ableToCallShareWindow = true;

class StickersScreen extends StatelessWidget {
  const StickersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stickers',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: [
                  ...List.generate(17, (index) {
                    return Builder(builder: (ctx) {
                      return GestureDetector(
                          onTap: () async {
                            if (ableToCallShareWindow) {
                              ableToCallShareWindow = false;
                              final box = ctx.findRenderObject() as RenderBox?;
                              String copiedFilePath = await copyAssetToDevice(
                                  'assets/${index + 1}.webp');
                              await Share.shareXFiles(
                                [XFile(copiedFilePath)],
                                sharePositionOrigin:
                                    box!.localToGlobal(Offset.zero) & box.size,
                              ).whenComplete(() {
                                deleteFile(copiedFilePath);
                                ableToCallShareWindow = true;
                              });
                            }
                          },
                          child: Image.asset(
                            'assets/${index + 1}.webp',
                            height: MediaQuery.of(context).size.width / 5 - 20,
                            width: MediaQuery.of(context).size.width / 5 - 20,
                          ));
                    });
                  }),
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
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
              Text('or',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.blue)),
              const SizedBox(height: 15),
              FittedBox(
                child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.blueAccent,
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
              const SizedBox(height: 30),
            ],
          ),
        ),
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
      'assets/17.webp': ['😗'],
    };

    var stickerPack = WhatsappStickers(
      identifier: 'lionsTeamWhatsAppStickers',
      name: 'Baseball Stickers',
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
