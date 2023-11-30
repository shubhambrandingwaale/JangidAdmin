// ignore_for_file: unused_element, non_constant_identifier_names, unused_local_variable, must_be_immutable, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

import 'Regular.dart';


class MyAnimatedbutton extends StatefulWidget {
  String lable;
  double height;
  double width;
  Color? bgcolor;
  Color color;
  double size;
  double? Borderradius;
  bool? bold;
  bool? isdisibile;
  Function onPressed;
  final Decoration? decoration;
  bool? isloading;
  Duration? duration;
  final EdgeInsetsGeometry? padding;
  Widget? loadingwidget;
  bool textisbold = false;
  String? fontfamily;
  FontWeight? fontweigth;
  MyAnimatedbutton(
      {Key? key,
      this.isloading,
      this.duration,
      required this.lable,
      required this.height,
      required this.width,
      required this.bgcolor,
      required this.color,
      required this.size,
      required this.onPressed,
      this.Borderradius,
      this.gridentColor,
      this.padding,
      this.decoration,
      this.loadingwidget,
      this.bold,
      this.textisbold = false,
      this.isdisibile = false,
      this.fontweigth,
      this.boxShadow,
      this.fontfamily})
      : super(key: key);
  List<Color>? gridentColor;
  List<BoxShadow>? boxShadow;
  @override
  State<MyAnimatedbutton> createState() => _MyAnimatedbuttonState();
}

class _MyAnimatedbuttonState extends State<MyAnimatedbutton>
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

  bool isAnimating = true;

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    Size dynamicsize = MediaQuery.of(context).size;
    final isstached = isAnimating || widget.isloading == false;
    return AnimatedContainer(
      onEnd: () => setState(() => isAnimating = !isAnimating),
      duration: widget.duration ?? const Duration(milliseconds: 1000),
      curve: Curves.easeIn,
      height: widget.height,
      width: widget.isloading ?? false ? widget.width * 0.3 : widget.width,
      child: !isstached
          ? SizedBox(
              height: 10,
              width: widget.width * 0.25,
              child: CircleAvatar(
                backgroundColor: widget.bgcolor,
                radius: 50,
                child: Center(
                  child: widget.loadingwidget ??
                      CircularProgressIndicator(color: Colors.white),
                ),
              ))
          : GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTap: () => widget.onPressed(),
              child: Transform.scale(
                scale: _scale,
                child: Container(
                  margin: widget.padding,
                  height: widget.height,
                  width: widget.width,
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Regular(
                        text: widget.lable,
                        fontFamily: widget.fontfamily,
                        fontWeight: widget.fontweigth,
                        size: widget.size,
                        color: widget.color),
                  ),
                  decoration: widget.decoration ??
                      BoxDecoration(
                        boxShadow: widget.boxShadow,
                        gradient: widget.gridentColor != null
                            ? LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: const [0.1, 0.7],
                                tileMode: TileMode.decal,
                                colors: widget.gridentColor!)
                            : null,
                        borderRadius:
                            BorderRadius.circular(widget.Borderradius ?? 10),
                        color: widget.bgcolor ?? Colors.white,
                      ),
                ),
              ),
            ),
    );
  }
}
