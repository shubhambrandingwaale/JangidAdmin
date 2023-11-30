import 'dart:io';

import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoGallery extends StatelessWidget {
  final List<dynamic> imagesArray;
  final PageController pageController;
  String comeFrom;
  PhotoGallery(
      {super.key,
      required this.imagesArray,
      required this.pageController,
      required this.comeFrom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, 'Gallery', Appcolor.black,
          leading: InkWell(
            onTap: () => Routesapp.gotoBackPage(context),
            child: Icon(
              Icons.arrow_back,
              color: Appcolor.black,
            ),
          )),
      body: PhotoViewGallery.builder(
          pageController: pageController,
          scrollPhysics: const BouncingScrollPhysics(),
          loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes!,
                  ),
                ),
              ),
          itemCount: imagesArray.length,
          builder: (BuildContext context, int index) {
            if (imagesArray[index] is XFile) {
              // Handle XFile
              return PhotoViewGalleryPageOptions(
                imageProvider: FileImage(File(imagesArray[index].path)),
                initialScale: PhotoViewComputedScale.contained * 0.8,
              );
            } else if (imagesArray[index] is String) {
              // Handle image URL (string)
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(
                    'https://jangid.nlaolympiad.in${imagesArray[index]}'),
                initialScale: PhotoViewComputedScale.contained * 0.8,
              );
            }
            // You can add more conditions for other data types if needed
            return PhotoViewGalleryPageOptions(
              imageProvider: AssetImage(
                  'path_to_placeholder_image'), // Provide a placeholder image path
              initialScale: PhotoViewComputedScale.contained * 0.8,
            );
          }),
    );
  }
}
