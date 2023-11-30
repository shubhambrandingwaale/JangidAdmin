import 'dart:io';

import 'package:attendance_admin/Components/AllWorkersComponents.dart';
import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/Image.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/Models/Brain.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/supervisor/controller/SuperVisorRepository.dart';
import 'package:attendance_admin/ui/workers/controller/WorkerProfileRepository.dart';
import 'package:attendance_admin/ui/workers/controller/WorkerRepository.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/CustomFont.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:attendance_admin/widgets/AnimatedButton.dart';
import 'package:attendance_admin/widgets/Button.dart';
import 'package:attendance_admin/widgets/CatchImage.dart';
import 'package:attendance_admin/widgets/CustomTextFeilds.dart';
import 'package:attendance_admin/widgets/Regular.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuperVisorProfileController extends StatelessWidget {
  SuperVisorProfileController({Key? key, required this.superVisorId})
      : super(key: key);
  int superVisorId = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SuperVisorRepository(),
      child: Consumer(
        builder: (context, SuperVisorRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return SuperVisorProfile(
                SuperVisorId: superVisorId,
              );
            case Status.Unauthenticated:
              return SuperVisorProfile(
                SuperVisorId: superVisorId,
              );
            case Status.Authenticating:
              return SuperVisorProfile(
                SuperVisorId: superVisorId,
              );
            case Status.Authenticated:
              return SuperVisorProfile(
                SuperVisorId: superVisorId,
              );
            case Status.error:
              return SuperVisorProfile(
                SuperVisorId: superVisorId,
              );
          }
        },
      ),
    );
  }
}

class SuperVisorProfile extends StatefulWidget {
  SuperVisorProfile({super.key, required this.SuperVisorId});
  int SuperVisorId = 0;

  @override
  State<SuperVisorProfile> createState() => _WorkerProfileState();
}

class _WorkerProfileState extends State<SuperVisorProfile> {
  Future<void> refresh() async {
    final auth = context.read<SuperVisorRepository>();
    auth.getSuperVisorById(context, widget.SuperVisorId);
  }

  @override
  void initState() {
    final auth = context.read<SuperVisorRepository>();
    auth.getSuperVisorById(context, widget.SuperVisorId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = context.watch<SuperVisorRepository>();
    return Scaffold(
      backgroundColor: light_black,
      body: auth.status == Status.Authenticating
          ? const CircularProgressIndicator()
          : RefreshIndicator(
              onRefresh: refresh,
              color: Appcolor.blue,
              child: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MainComponents().back('back',
                              () => Routesapp.gotoAllSuperVisor(context)),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius:
                                        0.5, // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  MainComponents().txtview14(
                                      '${auth.listOfData["wallet_balance"]}'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  MainComponents().Images(walleticon, 30.0),
                                ],
                              ),
                            ),
                          ),
                          // MainComponents().Wallet(
                          //     '${auth.listOfData["wallet_balance"]}', () => {}),
                        ],
                      ),
                      Container(
                        child: Column(
                          children: [
                            cacheImage(
                              'https://jangid.nlaolympiad.in${auth.listOfData["profile_img"]}',
                              100,
                              100,
                              BoxFit.cover,
                              shape: BoxShape.circle,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                padding: const EdgeInsets.all(20),
                                decoration:
                                    MainComponents().decoration(Colors.white),
                                child: Column(
                                  children: [
                                    MainComponents()
                                        .txtview14(auth.listOfData["fullname"]),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    MainComponents()
                                        .txtview14(auth.listOfData["email"]),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, top: 20, bottom: 10),
                        child: Row(
                          children: [
                            Regular(
                              text: 'Add Money to wallet',
                              size: 18,
                              color: Appcolor.black,
                              fontWeight: CustomFontWeight.semibold,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            CustomTextFeild(
                                HintText: 'Enter Amount',
                                Radius: 10,
                                width: size.width * 0.88,
                                controller: auth.amountController,
                                TextInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                obscureText: false,
                                isOutlineInputBorder: true),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      MyAnimatedbutton(
                          lable: 'Add wallet balance',
                          height: 50,
                          width: size.width * 0.88,
                          bgcolor: Appcolor.blue,
                          color: Appcolor.White,
                          size: 15,
                          onPressed: () {
                            if (auth.amountController.text.isNotEmpty) {
                              auth.UpdateWalletBalance(
                                  context,
                                  auth.amountController.text,
                                  widget.SuperVisorId);
                            } else {
                              Util.showmessagebar(
                                  context, 'Please Enter Amount',
                                  iserror: true);
                            }
                          })

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 20, vertical: 10),
                      //   child: My(
                      //     children: [
                      //       CustomTextFeild(
                      //           HintText: 'Enter Amount',
                      //           Radius: 10,
                      //           width: size.width * 0.88,
                      //           TextInputAction: TextInputAction.done,
                      //           keyboardType: TextInputType.number,
                      //           obscureText: false,
                      //           isOutlineInputBorder: true),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

void _showDialog(BuildContext context) {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Amount and Reason'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(labelText: 'Reason'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Submit'),
            onPressed: () {
              // Process the amount and reason here
              String amount = amountController.text;
              String reason = reasonController.text;
              // You can handle the data as needed, for example, send it to an API or update your state.
              print('Amount: $amount, Reason: $reason');
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
