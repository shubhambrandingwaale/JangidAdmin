import 'dart:convert';

import 'package:attendance_admin/Components/BottomSheet.dart';
import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/Image.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/Models/Brain.dart';
import 'package:attendance_admin/Models/TokenData.dart';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/home/controller/HomeRepository.dart';
import 'package:attendance_admin/ui/supervisor/view/AllSupervisors.dart';
import 'package:attendance_admin/ui/Location/view/ViewAllSites.dart';
import 'package:attendance_admin/ui/addSiteLocation/view/AddSiteLocation.dart';
import 'package:attendance_admin/ui/supervisor/view/AddSuperVisor.dart';
import 'package:attendance_admin/ui/workers/view/AllWorkersList.dart';
import 'package:attendance_admin/ui/workers/view/AddWorker.dart';
import 'package:attendance_admin/utility/Colors.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:attendance_admin/widgets/MyClick.dart';
import 'package:attendance_admin/widgets/ToastBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utility/MyStatus.dart';

class HomeController extends StatelessWidget {
  const HomeController({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeRepository(),
      child: Consumer(
        builder: (context, HomeRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return HomePage();
            case Status.Unauthenticated:
              return HomePage();
            case Status.Authenticating:
              return HomePage();
            case Status.Authenticated:
              return HomePage();
            case Status.error:
              return HomePage();
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> refresh() async {
    await DashDataAPI();
  }

  var decode;
  String ongoing_sites = "0";
  String complete_sites = "0";
  String total_workers = "0";
  String present_workers = "0";
  String total_supervisors = "0";
  String present_supervisors = "0";
  String expense_month = "0";
  String income_month = "0";
  Future<void> DashDataAPI() async {
    Bottomsheet().sheet(context);
    var data = await BrainCode().Dashboard(await token);
    setState(() {
      decode = jsonDecode(data);
      if (ongoing_sites.isEmpty) {
        Navigator.pop(context);
        setState(() {
          ongoing_sites = "0";
        });
      }
      if (complete_sites.isEmpty) {
        Navigator.pop(context);
        setState(() {
          complete_sites = "0";
        });
      }
      if (total_workers.isEmpty) {
        Navigator.pop(context);
        setState(() {
          total_workers = "0";
        });
      }
      if (present_workers.isEmpty) {
        Navigator.pop(context);
        setState(() {
          present_workers = "0";
        });
      }
      if (total_supervisors.isEmpty) {
        Navigator.pop(context);
        setState(() {
          total_supervisors = "0";
        });
      }
      if (present_supervisors.isEmpty) {
        Navigator.pop(context);
        setState(() {
          present_supervisors = "0";
        });
        if (expense_month.isEmpty) {
          Navigator.pop(context);
          setState(() {
            expense_month = "0";
          });
        }
        if (income_month.isEmpty) {
          Navigator.pop(context);
          setState(() {
            income_month = "0";
          });
        }
      } else {
        setState(() {
          Navigator.pop(context);
          ongoing_sites = decode['ongoing_sites'];
          complete_sites = decode['completed_sites'];
          total_workers = decode['total_workers'];
          present_workers = decode['present_workers'];
          total_supervisors = decode['total_supervisors'];
          present_supervisors = decode['present_supervisors'];
          income_month = decode['income_this_month'];
          expense_month = decode['expense_this_month'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      DashDataAPI();
    });
  }

  DateTime currentBackPressTime = DateTime.now();
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toastbar.showToast(msg: "double tap to exit !!");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: light_black,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: refresh,
            color: Appcolor.blue,
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.5,
                                  blurRadius: 0.5, // changes position of shadow
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MainComponents().txtview14('DashBoard'),
                                const SizedBox(
                                  width: 10,
                                ),
                                // MainComponents().Images(logout, 30.0)
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Util.logoutalertnew(context);
                            },
                            child: Container(
                              height: 50,
                              width: 100,
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MainComponents().txtview14('Logout'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  MainComponents().Images(logout, 30.0)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Card(
                            child: MainComponents().homeCards(mappin,
                                "Ongoing Sites", ongoing_sites, "locations"),
                          )),
                          Expanded(
                              child: Card(
                            child: MainComponents().homeCards(mappin,
                                "Complete Sites", complete_sites, "locations"),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Card(
                            child: MainComponents().homeCards(workers,
                                "Total Workers", total_workers, "workers"),
                          )),
                          Expanded(
                              child: Card(
                            child: MyClick(
                              onPressed: () {
                                Routesapp.gotoPresentWorkerScreen(context);
                              },
                              child: MainComponents().homeCards(
                                  construction,
                                  "Present Workers",
                                  present_workers,
                                  "workers"),
                            ),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Card(
                            child: MainComponents().homeCards(
                                employee,
                                "Total Supervisor",
                                total_supervisors,
                                "Supervisor"),
                          )),
                          Expanded(
                              child: Card(
                            child: MainComponents().homeCards(
                                manraising,
                                "Present Supervisors",
                                present_supervisors,
                                "Supervisor"),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Card(
                            child: MainComponents().homeCards(employee,
                                "Expense this Month", expense_month, "rs."),
                          )),
                          Expanded(
                              child: Card(
                            child: MainComponents().homeCards(
                                manraising,
                                "Income this Month",
                                income_month == "" ? "0" : income_month,
                                "rs."),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MainComponents().SiteLocation2(
                          "Sites Locations",
                          "All Sites",
                          "Add New",
                          mappin,
                          add_new,
                          context,
                          AddSiteController(),
                          AddSiteLocationController(
                              iscomeFromHomeScreen: true)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MainComponents().SiteLocation2(
                          "Supervisor",
                          "AllSupervisor",
                          "Add New",
                          worker,
                          add_new,
                          context,
                          AlSuperVisorController(),
                          AddSuperVisorController(
                            iscomeFromHomeScreen: true,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MainComponents().SiteLocation2(
                          "Workers",
                          "AllWorkers",
                          "Add New",
                          worker,
                          add_new,
                          context,
                          WorkerListController(),
                          AddNewWorkerController(iscomeFromHomeScreen: true)),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: MainComponents().card_with_txt_bt(
                    //       "Total Expenses",
                    //       "Rs.800000",
                    //       "View All",
                    //       Colors.red,
                    //       context,
                    //       ExpenseListController()),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: MainComponents().card_with_txt_bt(
                    //       "Total Income",
                    //       "Rs.900000",
                    //       "",
                    //       Colors.transparent,
                    //       context,
                    //       AddIncome()),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //     padding: EdgeInsets.all(8),
                    //     alignment: Alignment.centerLeft,
                    //     child: MainComponents().txtview18("Deductions")),
                    // Padding(
                    //   padding: const EdgeInsets.all(3.0),
                    //   child: Card(child: MainComponents().Deductions_list(5)),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
