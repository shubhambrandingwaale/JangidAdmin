// ignore_for_file: file_names

import 'SpinKitCircle.dart';
import 'package:flutter/material.dart';

import 'Beat.dart';
import 'BouncingBall.dart';
import 'DicreteCircle.dart';
import 'FallingDot.dart';
import 'FourRotatingDots.dart';
import 'InkDrop.dart';
import 'PouringHourGlassRefined.dart';
import 'PrograssiveDots.dart';
import 'SpinKitPouringHourGlass.dart';
import 'SpinKitRotatingCircle.dart';
import 'ThreeArchedCricle.dart';
import 'WaveDots.dart';
import 'AnimatedProgress.dart';

class AnimatedLoadingWidget {
  AnimatedLoadingWidget._();

  /// A ball falls inside a ring cut out when face up and falls when face down.
  /// Required color is applied to the ring and dot.
  static Widget fallingDot({
    required Color color,
    required double size,
    Key? key,
  }) {
    return FallingDot(
      color: color,
      size: size,
      key: key,
    );
  }

  /// Four dots shrink to the center and expand and rotates 315 degree.
  /// Required color is applied to four dots.
  static Widget fourRotatingDots({
    required Color color,
    double size = 40,
    Key? key,
  }) {
    return FourRotatingDots(
      color: color,
      size: size,
      key: key,
    );
  }

  /// Four dots in a row left most scales down and a new dot emerge from right.
  /// Required color is applied to four dots.
  static Widget prograssiveDots({
    required Color color,
    required double size,
    Key? key,
  }) {
    return PrograssiveDots(
      color: color,
      size: size,
      key: key,
    );
  }

  /// A dot becomes a full ring and also have discrete following rings.
  /// Required color is applied to the circular ring.
  static Widget discreteCircle({
    required Color color,
    required double size,
    Color secondRingColor = Colors.teal,
    Color thirdRingColor = Colors.orange,
    Key? key,
  }) {
    return DiscreteCircle(
      color: color,
      size: size,
      secondCircleColor: secondRingColor,
      thirdCircleColor: thirdRingColor,
      key: key,
    );
  }

  /// Three arc at 60 degree shrinks to a dot while rotating and comes back to inital.
  /// Required color is applied to all three arc.
  static Widget threeArchedCircle({
    required Color color,
    required double size,
    Key? key,
  }) {
    return ThreeArchedCircle(
      color: color,
      size: size,
      key: key,
    );
  }

  /// A ball fall from top and bounce back
  /// Required color is applied to the ball.
  static Widget bouncingBall({
    required Color color,
    required double size,
    Key? key,
  }) {
    return BouncingBall(
      color: color,
      size: size,
      key: key,
    );
  }

  /// One ring emerge from the center and scale up until touches the outer ring.
  /// Then the outer ring expand a bit then come back to normal.
  /// Required color is applied to both rings.
  static Widget beat({
    required Color color,
    required double size,
    Key? key,
  }) {
    return Beat(
      color: color,
      size: size,
      key: key,
    );
  }

  /// A dot falls down then completes a circle then become to dot again.
  /// Required color is applied to the ring and the dot.
  static Widget inkDrop({
    required Color color,
    required double size,
    Key? key,
  }) {
    return InkDrop(
      color: color,
      size: size,
      key: key,
    );
  }

  /// Three dots go up and down give wave effect. Required color is applied to
  /// all dots.
  static Widget waveDots({
    required Color color,
    required double size,
    Key? key,
  }) {
    return WaveDots(
      color: color,
      size: size,
      key: key,
    );
  }

  static Widget pouringHourGlass({required Color color, Key? key}) {
    return SpinKitPouringHourGlass(color: color);
  }

  static Widget pouringHourGlassRefined({required Color color, Key? key}) {
    return SpinKitPouringHourGlassRefined(color: color);
  }

  static Widget rotatingCircle(
      {required Color color,
      required double size,
      Duration? duration,
      Key? key}) {
    return SpinKitRotatingCircle(
      color: color,
      size: size,
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  static Widget spinCircle(
      {required Color color, double? size, Duration? duration, Key? key}) {
    return SpinKitCircle(
      color: color,
      duration: duration ?? const Duration(seconds: 2),
      size: size ?? 30,
    );
  }

  static Widget animatedProgressBar({Key? key}) {
    return AnimatedProgressBar();
  }
}
