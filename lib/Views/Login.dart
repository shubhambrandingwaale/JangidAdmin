import 'dart:convert';

import 'package:attendance_admin/Components/BottomSheet.dart';
import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/Components/SharePref.dart';
import 'package:attendance_admin/Components/toast.dart';
import 'package:attendance_admin/Models/Brain.dart';
import 'package:attendance_admin/ui/home/view/HomePage.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username_control = TextEditingController();
  TextEditingController password_control = TextEditingController();
  bool isPasswordVisible = false;

  void login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeController()));
  }

  Future<void> _requestGalleryPermission() async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
    } else {}
  }

  @override
  void initState() {
    _requestGalleryPermission();
    super.initState();
  }

  Future<void> SaveLogin() async {
    Bottomsheet().sheet(context);
    if (username_control.text.toString().isEmpty) {
      Navigator.pop(context);
      return Toast().warning(context, "Login", "Enter Username");
    }
    if (password_control.text.toString().isEmpty) {
      Navigator.pop(context);
      return Toast().warning(context, "Login", "Enter Password");
    } else {
      var Logindata = await BrainCode().login_supervisor(
          username_control.text.toString(), password_control.text.toString());

      try {
        var jsondecode = jsonDecode(Logindata);
        if (jsondecode['errors'].toString() != "null") {
          Toast().Fail(
              context, "Login", "Name must be at least 3 characters long");
        } else {
          if (jsondecode['admin'].toString() != "null") {
            //Navigator.pop(context);
            var decodedjson = jsondecode['token'];
            SharePref().SaveToken(decodedjson);
            await Util.savetoken(decodedjson);
            BrainCode().Navigatorpush(context, HomeController());
          } else {
            Toast()
                .Fail(context, "Login", '${jsondecode['message'].toString()}');
          }
        }
      } catch (e) {
        Toast().Fail(context, "Login", "Login Fail");
      }
      // var jsondecode = jsonDecode(Logindata);
      // if (jsondecode['supervisor'].toString().isNotEmpty) {
      //   var decodedjson = jsondecode['token'];
      //    SharePref().SaveToken(decodedjson);
      //   await Util.savetoken(decodedjson);
      //   BrainCode().Navigatorpush(context, HomePage());
      // }
      // else{
      //   Toast().Fail(context, "Login", "Login Fail");
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
            ),
            Column(
              children: [
                MainComponents().txtview28("Welcome Back"),
                MainComponents().Cards(
                    username_control,
                    password_control,
                    SaveLogin,
                    blue,
                    isPasswordVisible: isPasswordVisible,
                    TextInputType.name, passwordToggle: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
