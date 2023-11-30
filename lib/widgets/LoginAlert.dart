import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginAlertScreen extends StatelessWidget {
  LoginAlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/lock.json", repeat: false, width: 200),
            Text(
              "You must be logged in\nto use this feature.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Expanded(
                    child: Mybutton(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: Appcolor.travelCardGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        lable: 'Login',
                        height: 50,
                        width: size.width * 0.80,
                        bgcolor: Appcolor.PrimaryColor,
                        color: Appcolor.White,
                        size: 16,
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          // Routesapp.gotoLoginPage(context);
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
