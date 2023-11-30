// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'HexColor.dart';
import 'Regular.dart';
class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({super.key, required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 200) {
      firstHalf = widget.text.substring(0, 200);
      secondHalf = widget.text.substring(200, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Regular(
              text: firstHalf,
              start: true,
              size: 14,
              color: HexColor("#909090"))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Regular(
                    text: flag ? ("$firstHalf...") : (firstHalf + secondHalf),
                    start: true,
                    size: 14,
                    color: HexColor("#909090")),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Regular(
                        text: flag ? "Read more" : "Read less",
                        color: HexColor("#242424"),
                        size: 16,
                      ),
                      const SizedBox(),
                      Icon(flag
                          ? Icons.keyboard_arrow_down_outlined
                          : Icons.keyboard_arrow_up_outlined)
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
