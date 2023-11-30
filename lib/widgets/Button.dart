// ignore_for_file: non_constant_identifier_names, must_be_immutable, sort_child_properties_last, unused_element

import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFont.dart';
import 'package:flutter/material.dart';

import 'Regular.dart';
class Mybutton extends StatefulWidget {
  String lable;
  double height;
  double width;
  Color bgcolor;
  Color color;
  double size;
  double? Borderradius;
  bool? bold;
  Function onPressed;
  final Decoration? decoration;
  Widget? replacewidget;
  Border? border;
  String? style;

  final EdgeInsetsGeometry? padding;
  var fontFamily;
  var fontWeight;
  Mybutton(
      {Key? key,
        required this.lable,
        required this.height,
        required this.width,
        this.replacewidget,
        this.border,
        required this.bgcolor,
        required this.color,
        this.iscentertitile,
        required this.size,
        required this.onPressed,
        this.fontWeight = FontWeight.normal,
        this.fontFamily,
        this.Borderradius,
        this.padding,
        this.decoration,
        this.Textalignment,
        this.gridentColor,
        this.bold,
        this.style
      })

      : super(key: key);
  bool? iscentertitile;
  AlignmentGeometry? Textalignment;
  List<Color>? gridentColor;

  @override
  State<Mybutton> createState() => _MybuttonState();
}

class _MybuttonState extends State<Mybutton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward(from: 1);
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse(from: 0);
  }

  dynamic icon;

  EdgeInsetsGeometry? get _paddingIncludingDecoration {
    if (widget.decoration == null || widget.decoration!.padding == null) {
      return widget.padding;
    }

    final EdgeInsetsGeometry? decorationPadding = widget.decoration!.padding;

    if (widget.padding == null) return decorationPadding;

    return widget.padding!.add(decorationPadding!);
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTap: () => widget.onPressed(),
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: widget.height,
          width: widget.width,
          padding: _paddingIncludingDecoration,

          alignment: widget.Textalignment ?? Alignment.center,
          child: Visibility(
            child: widget.replacewidget ??
                Regular(
                  fontWeight: widget.fontWeight,
                  fontFamily: widget.fontFamily,
                  text: widget.lable,
                  //fontFamily: FontConstant.lato,
                  size: widget.size,
                  start: widget.iscentertitile,
                  color: Appcolor.White,
                  isunderline: false,
                ),
            visible: widget.replacewidget == null ? false : true,
            replacement: Regular(
              fontWeight: widget.fontWeight,
              fontFamily: widget.fontFamily,
              text: widget.lable,
              //fontFamily: FontConstant.lato,
              size: widget.size,
              start: widget.iscentertitile,
              color: widget.color,
              isunderline: false,
            ),
          ),
          decoration: widget.decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(widget.Borderradius ?? 10),
                color: widget.bgcolor,
                gradient: widget.gridentColor != null
                    ? LinearGradient(
                  colors: widget.gridentColor!,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    : null,
              ),

          // color: widget.bgcolor,
        ),
      ),
    );
  }
}