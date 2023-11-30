import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFont.dart';
import 'package:attendance_admin/widgets/Button.dart';
import 'package:attendance_admin/widgets/Regular.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:location/location.dart' as locator;

class LocationAlertScreen extends StatelessWidget {
  LocationAlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/enableLocation.json",
                repeat: true, width: 200),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Regular(
                text:
                    'You need to allow access to\nlocation in order to use CouchStay Travel App.\nPlease try again and hit OK.',
                size: 20,
                color: Appcolor.black,
                textAlign: TextAlign.center,
                fontFamily: CustomFont.poppins,
                fontWeight: CustomFontWeight.regular,
              ),
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
                        lable: 'Try Again',
                        height: 50,
                        width: size.width * 0.80,
                        bgcolor: Appcolor.PrimaryColor,
                        color: Appcolor.White,
                        size: 16,
                        fontWeight: FontWeight.bold,
                        onPressed: () async {
                          locator.Location location = locator.Location();
                          bool serviceEnabled = await location.requestService();
                          if (serviceEnabled) {
                            // Routesapp.gotoHomePage(context);
                            return;
                          }
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
