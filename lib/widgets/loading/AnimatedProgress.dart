// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatefulWidget {
  AnimatedProgressBar({Key? key}) : super(key: key);

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _radiusAnimation;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();
    _rotationAnimation = Tween(begin: 0.radians, end: 180.radians).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _radiusAnimation = Tween(begin: 20.0, end: 30.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _borderAnimation = Tween(begin: 5.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.rotate(
        angle: _rotationAnimation.value,
        child: ScaleTransition(
          scale: Tween(begin: 0.7, end: 1.0).animate(_controller),
          child: CustomPaint(
            painter: ProgressBarPainter(
              rotationAnimation: _rotationAnimation,
              radiusAnimation: _radiusAnimation,
              borderAnimation: _borderAnimation,
            ),
            size: MediaQuery.of(context).size,
          ),
        ),
      ),
    );
  }
}

class ProgressBarPainter extends CustomPainter {
  ProgressBarPainter({
    required this.rotationAnimation,
    required this.radiusAnimation,
    required this.borderAnimation,
  });
  final Animation<double> rotationAnimation;
  final Animation<double> radiusAnimation;
  final Animation<double> borderAnimation;
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.pink,
      Colors.purpleAccent,
    ];

    for (var i = 0; i < 360; i += 40) {
      final paint = Paint()
        ..color =
            Color.fromRGBO(255 - (i * 8), 255 - (i * 3), 255 - (i * 5), 1.0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderAnimation.value;

      canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCircle(
              center: toPolar(
                size.center(Offset.zero),
                i.radians,
                rotationAnimation.value <= 90.radians ? 100 : 80,
              ),
              radius: radiusAnimation.value,
            ),
            Radius.circular(rotationAnimation.value <= 90.radians ? 20 : 5),
          ),
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

extension NumX<T extends num> on T {
  double get radians => (this * math.pi) / 180.0;
}

extension StringX on String {
  String get formatText => length < 2 ? '0$this' : this;
}

Offset toPolar(Offset center, double radians, double radius) {
  return center +
      Offset(radius * math.cos(radians), radius * math.sin(radians));
}
