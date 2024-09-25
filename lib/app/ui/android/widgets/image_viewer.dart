import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import '../../../data/constants/miscellaneous.dart';
import 'miscellaneous.dart';
class ImageViewer extends StatefulWidget {
  // final String path;
  const ImageViewer({Key? key}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late String imagePath;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePath = Get.arguments as String;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: appColors["background"]!,
        child: Column(

          children: [
            headerBar("Image Viewer",parent: true),
            Expanded(
              child: PhotoView(
                backgroundDecoration: BoxDecoration(
                  color: appColors["background"]!
                ),
                imageProvider: NetworkImage(imagePath),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
