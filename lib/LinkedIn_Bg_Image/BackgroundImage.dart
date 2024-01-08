import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'ImageHolder.dart';

class BackgroundImage extends StatefulWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  State<BackgroundImage> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  GlobalKey _containerKey = GlobalKey();

  Future<void> _captureAndSave() async {
    try {
      RenderRepaintBoundary boundary =
      _containerKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        final blob = html.Blob([Uint8List.fromList(pngBytes)]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'blank'
          ..download = 'Nikhil.png';
        html.document.body?.children.add(anchor);
        anchor.click();
        html.document.body?.children.remove(anchor);

        html.Url.revokeObjectUrl(url);

        // Print a message indicating the image has been downloaded
        print('Image downloaded successfully');
      } else {
        print('Error converting image to byte data');
      }
    } catch (e) {
      print('Error capturing and saving image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RepaintBoundary(
            key: _containerKey,
            child: Container(
              width: 784.0,
              height: 196.0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0XFF062A68),
                    Color(0XFF07265F),
                    Color(0XFF141042),
                  ],
                ),
              ),
              child: const ImageHolder(),
            ),
          ),
          const SizedBox(height: 150,),
          ElevatedButton(
            onPressed: _captureAndSave,
            child: const Text("Download Image"),
          ),
        ],
      ),
    );
  }
}
