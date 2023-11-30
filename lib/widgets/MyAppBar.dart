import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFont.dart';
import 'package:attendance_admin/widgets/Regular.dart';
import 'package:flutter/material.dart';

AppBar MyAppBar(BuildContext context, String title, Color titleColor,
    {Widget? leading,
    double fontsize = 15.0,
    FontWeight fontWeight = FontWeight.w600,
    List<Widget>? action,
    bool isCenter = false,
    Color? bgColor}) {
  return AppBar(
    leading: leading,
    title: Regular(
        text: title,
        size: fontsize,
        color: titleColor,
        fontFamily: CustomFont.Montserrat,
        fontWeight: fontWeight),
    actions: action,
    centerTitle: isCenter,
    backgroundColor: bgColor ?? Appcolor.White,
    elevation: 0,
  );
}
