// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/HelpImages.dart';
import 'package:flutter/material.dart';

Widget cacheImage(String url, double height, double width, BoxFit fit,
        {BoxShape shape = BoxShape.rectangle,
        BorderRadius? borderRadius,
        Widget? widget,
        bool isCircular = true}) =>
    CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          shape: shape,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        height: height,
        width: width,
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) =>
          widget ??
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Appcolor.lightBlue,
                image:
                    DecorationImage(image: AssetImage(AppImages.defaultimage))),
          ),
    );
