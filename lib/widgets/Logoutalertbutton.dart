import 'package:flutter/material.dart';
import 'package:attendance_admin/widgets/Regular.dart';

class logoutalertbutton extends StatelessWidget {
  String lable;
  double height;
  double width;
  Color bgcolor;
  Color color;
  dynamic icon;
  double size;
  bool? bold;
  logoutalertbutton(
      {Key? key,
      required this.lable,
      required this.height,
      required this.width,
      required this.bgcolor,
      required this.color,
      required this.size,
      this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        // ignore: sort_child_properties_last
        child: Regular(
          isunderline: false,
          text: lable,
          size: size,
          color: color,
        ),
        // decoration: BoxDecoration(
        //     color: bgcolor,
        //     border: Border.all(
        //       color: Colors.white,
        //       width: 1,
        //     ),
        //     borderRadius: BorderRadius.circular(20),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey,
        //       ),
        //     ]),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgcolor,
        ));
  }
}
