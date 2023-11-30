// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Regular extends StatelessWidget {
  String text;
  double size;
  Color color;
  int? lines;
  TextOverflow? textOverflow;
  bool? start;
  bool? isunderline;
  FontWeight? fontWeight;
  String? fontFamily;
  TextAlign? textAlign;
  Regular({
    Key? key,
    required this.text,
    required this.size,
    required this.color,
    this.isunderline,
    this.textOverflow,
    this.fontWeight,
    this.lines,
    this.fontFamily,
    this.textAlign,
    this.start,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if ((lines == null)) {
      return Text(
        text,
        textAlign: (start != null) ? TextAlign.start : textAlign,
        style: TextStyle(
            fontSize: size,
            color: color,
            overflow: textOverflow,
            fontWeight: fontWeight ?? FontWeight.w400,
            fontFamily: fontFamily,
            decoration: isunderline ?? false
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationStyle: TextDecorationStyle.solid,
            decorationThickness: 2),
      );
    } else {
      return Text(
        text,
        textAlign: (start != null) ? TextAlign.start : textAlign,
        overflow: TextOverflow.ellipsis,
        maxLines: lines,
        softWrap: false,
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: fontWeight ?? FontWeight.w400,
          fontFamily: fontFamily ?? "Poppins",
          decoration: isunderline ?? false
              ? TextDecoration.underline
              : TextDecoration.none,
          decorationStyle: TextDecorationStyle.dashed,
        ),
      );
    }
  }
}
