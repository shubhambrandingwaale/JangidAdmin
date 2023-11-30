// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyClick extends StatefulWidget {
  final Widget child;
  String? tooltipmessage;
  final VoidCallback onPressed;
  final double scaleFactor;
  final Duration duration;
  final bool stayOnBottom;

  MyClick({
    Key? key,
    required this.child,
    required this.onPressed,
    this.scaleFactor = 1,
    this.tooltipmessage,
    this.duration = const Duration(milliseconds: 200),
    this.stayOnBottom = false,
  }) : super(key: key);

  @override
  _MyClickState createState() => _MyClickState();
}

class _MyClickState extends State<MyClick> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late double _scale;

  final GlobalKey _childKey = GlobalKey();

  bool _isOutside = false;

  Widget get child => widget.child;

  VoidCallback get onPressed => widget.onPressed;

  double get scaleFactor => widget.scaleFactor;

  Duration get duration => widget.duration;

  bool get _stayOnBottom => widget.stayOnBottom;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: duration,
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void didUpdateWidget(MyClick oldWidget) {
    if (oldWidget.stayOnBottom != _stayOnBottom) {
      if (!_stayOnBottom) {
        _reverseAnimation();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  /// Dispose the animation controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Each time the [_controller]'s value changes, build() will be called
  /// We just have to calculate the appropriate scale from the controller value
  /// and pass it to our Transform.scale widget
  @override
  Widget build(BuildContext context) {
    _scale = 1 - (_controller.value * scaleFactor);
    return Tooltip(
      message: widget.tooltipmessage ?? '',
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onLongPressEnd: (details) => _onLongPressEnd(details, context),
        // onHorizontalDragEnd: _onDragEnd,
        // // onVerticalDragEnd: _onDragEnd,
        // onHorizontalDragUpdate: (details) => _onDragUpdate(details, context),
        // onVerticalDragUpdate: (details) => _onDragUpdate(details, context),
        child: Transform.scale(
          key: _childKey,
          scale: _scale,
          child: child,
        ),
      ),
    );
  }

  /// Simple method called when we need to notify the user of a press event
  _triggerOnPressed() {
    onPressed();
  }

  /// We start the animation
  _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  /// We reverse the animation and notify the user of a press event
  _onTapUp(TapUpDetails details) {
    if (!_stayOnBottom) {
      Future.delayed(duration, () {
        _reverseAnimation();
      });
    }

    _triggerOnPressed();
  }

  /// Here we are listening on each change when drag event is triggered
  /// We must keep the [_isOutside] value updated in order to use it later
  _onDragUpdate(DragUpdateDetails details, BuildContext context) {
    final Offset touchPosition = details.globalPosition;
    _isOutside = _isOutsideChildBox(touchPosition);
  }

  /// When this callback is triggered, we reverse the animation
  /// If the touch position is inside the children renderBox, we notify the user of a press event
  _onLongPressEnd(LongPressEndDetails details, BuildContext context) {
    final Offset touchPosition = details.globalPosition;

    if (!_isOutsideChildBox(touchPosition)) {
      _triggerOnPressed();
    }

    _reverseAnimation();
  }

  /// When this callback is triggered, we reverse the animation
  /// As we do not have position details, we use the [_isOutside] field to know
  /// if we need to notify the user of a press event
  _onDragEnd(DragEndDetails details) {
    if (!_isOutside) {
      _triggerOnPressed();
    }
    _reverseAnimation();
  }

  _reverseAnimation() {
    if (mounted) {
      _controller.reverse();
    }
  }

  /// Method called when we need to now if a specific touch position is inside the given
  /// child render box
  bool _isOutsideChildBox(Offset touchPosition) {
    final RenderBox? childRenderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;
    if (childRenderBox == null) {
      return true;
    }
    final Size childSize = childRenderBox.size;
    final Offset childPosition = childRenderBox.localToGlobal(Offset.zero);

    return (touchPosition.dx < childPosition.dx ||
        touchPosition.dx > childPosition.dx + childSize.width ||
        touchPosition.dy < childPosition.dy ||
        touchPosition.dy > childPosition.dy + childSize.height);
  }
}
