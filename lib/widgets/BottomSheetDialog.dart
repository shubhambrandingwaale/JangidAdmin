// ignore_for_file: non_constant_identifier_names

import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/widgets/HexColor.dart';
import 'package:flutter/material.dart';

ShowBottomTab(BuildContext context, Size size,
    {double? height, Widget? child, bool isheightby = false}) {
  Size size = MediaQuery.of(context).size;
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50))),
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Center(
              child: Container(
                width: 150,
                height: 6,
                decoration: BoxDecoration(color: Appcolor.PrimaryColor),
              ),
            ),
            const SizedBox(height: 10),
            child ?? Container()
          ],
        ),
      ),
    ),
  );
}

showBottomSheetTab(BuildContext context, Size size,
    {double? height, Widget? child, bool isheightby = false}) {
  return showBottomSheet(
    context: context,
    // isScrollControlled: true,
    backgroundColor: Appcolor.black.withOpacity(0.2),
    enableDrag: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50))),
    builder: (context) => Container(
      height: !isheightby ? (height ?? 250) : height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Center(
            child: Container(
              width: 150,
              height: 6,
              decoration: BoxDecoration(color: HexColor("#0F52BA")),
            ),
          ),
          const SizedBox(height: 10),
          child ?? Container()
        ],
      ),
    ),
  );
}
