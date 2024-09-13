import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FullScreenImage extends StatelessWidget {
  final String image;
  final String previewText;
  final String imageName;

  const FullScreenImage({super.key, required this.image, required this.previewText, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: image,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Tags: $previewText',
                style: const TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.download, color: Colors.white),
              onPressed: () => {_showPopup(context, true)},
            ),
          ),
          Positioned(
            top: 80,
            right: 20,
            child: IconButton(
              icon: const Icon(
                Icons.share_rounded,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () => {
                if (kIsWeb)
                  {_showPopup(context, false)}
                else
                  {
                    showBottomSheet(
                      builder: (context) {
                        return Container(
                          child: Text("Send the Image $imageName"),
                        );
                      },
                      context: context,
                    )
                  }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPopup(BuildContext context, bool isDownload) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Column(
            children: [
              Row(
                children: [
                  Icon(
                    isDownload ? Icons.download : Icons.share,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    isDownload ? 'Downloading.....' : 'Share',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 28,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  imageName,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue.shade400),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
