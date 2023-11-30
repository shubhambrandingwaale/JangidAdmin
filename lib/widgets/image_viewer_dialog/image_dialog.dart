import 'package:attendance_admin/widgets/CatchImage.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageDialogBox extends StatelessWidget {
  final String imageLink;
  const ImageDialogBox({super.key, required this.imageLink});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SimpleDialog(
      backgroundColor: Colors.transparent,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 400,
          width: 200,
          child: PhotoView(
            basePosition: Alignment.center,
            backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            imageProvider: NetworkImage(imageLink),
          ),
        )
      ],
    );
  }
}
