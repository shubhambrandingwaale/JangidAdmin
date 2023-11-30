// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:attendance_admin/utility/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Regular.dart';

class MyDropDownWidget extends StatefulWidget {
  MyDropDownWidget(
      {super.key,
      required this.data,
      required this.selecteddata,
      this.decoration,
      this.height,
      this.width,
      this.onchanged,
      this.textcolor,
      this.bgcolor,
      this.perfixWidget});
  List<String> data;
  String selecteddata;
  void Function(String?)? onchanged;
  Decoration? decoration;
  double? width, height, size;
  Color? textcolor;
  Widget? perfixWidget;
  Color? bgcolor;

  @override
  State<MyDropDownWidget> createState() => _MyDropDownWidgetState();
}

class _MyDropDownWidgetState extends State<MyDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.decoration == null ? widget.bgcolor : null,
      decoration: widget.decoration,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          widget.perfixWidget ?? Container(),
          Expanded(
            child: DropdownButton<String>(
              value: widget.selecteddata,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              isExpanded: true,
              style: const TextStyle(color: CupertinoColors.black),
              underline: Container(),
              onChanged: widget.onchanged,
              items: widget.data.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Regular(
                        text: value,
                        size: widget.size ?? 12,
                        color: widget.textcolor ?? Appcolor.grey));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
