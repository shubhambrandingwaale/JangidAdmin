import 'package:attendance_admin/ui/home/view/HomePage.dart';
import 'package:attendance_admin/Views/Login.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future.delayed(const Duration(seconds: 0), () async {
    Customlog('token is : ${await Util.gettoken()}');
    if (await Util.gettoken() == '') {
      runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ));
    } else {
      runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeController(),
      ));
    }
  });
}
