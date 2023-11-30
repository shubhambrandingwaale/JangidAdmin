import 'package:attendance_admin/ui/home/view/HomePage.dart';
import 'package:attendance_admin/Views/Login.dart';
import 'package:attendance_admin/ui/Location/view/Sitelocation.dart';
import 'package:attendance_admin/ui/Expense/view/AllExpense.dart';
import 'package:attendance_admin/ui/addSiteLocation/view/AddSiteLocation.dart';
import 'package:attendance_admin/ui/home/view/PresentWorker.dart';
import 'package:attendance_admin/ui/supervisor/view/AllSupervisors.dart';
import 'package:attendance_admin/ui/Location/view/ViewAllSites.dart';
import 'package:attendance_admin/ui/addSiteLocation/view/AddMapLocation.dart';
import 'package:attendance_admin/ui/addSiteLocation/view/AddWorkerSIte.dart';
import 'package:attendance_admin/ui/supervisor/view/AddSuperVisor.dart';
import 'package:attendance_admin/ui/supervisor/view/SuperVisorProfile.dart';
import 'package:attendance_admin/ui/workers/view/AddWorker.dart';
import 'package:attendance_admin/ui/workers/view/AllWorkersList.dart';
import 'package:attendance_admin/ui/workers/view/WorkerProfile.dart';
import 'package:flutter/material.dart';

class Routesapp {
  static gotoBackPage(BuildContext context) async => Navigator.pop(context);

  static gotoMapPage(
          BuildContext context, int siteId, bool isComeFromHome) async =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddLocationMapController(
                  siteId: siteId, isComeFromHome: isComeFromHome)));

  static gotoLoginPage(BuildContext context) async =>
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false);

  static viewAllSites(BuildContext context) async => Navigator.push(
      context, MaterialPageRoute(builder: (context) => AddSiteController()));

  // static viewAllWorkerList(BuildContext context) async => Navigator.push(
  //     context, MaterialPageRoute(builder: (context) => WorkerListController()));

  static viewAllExpenses(BuildContext context) async => Navigator.push(
      context, MaterialPageRoute(builder: (context) => AllExpense()));

  static gotoWorkerListScreen(BuildContext context) async => Navigator.push(
      context, MaterialPageRoute(builder: (context) => WorkerListController()));

  static gotoHomeScreen(BuildContext context) async => Navigator.push(
      context, MaterialPageRoute(builder: (context) => HomeController()));

  static gotoPresentWorkerScreen(BuildContext context) async => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PresentWorkerController()));

  static gotoViewSite(BuildContext context, int siteId) async => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SitelocationController(
                siteId: siteId,
              )));

  static gotoAddWorkerScreen(BuildContext context, bool iscomeFromHomeScreen,
          {int workerid = 0}) async =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddNewWorkerController(
                    iscomeFromHomeScreen: iscomeFromHomeScreen,
                    workerid: workerid,
                  )));

  static gotoWorkerProfile(BuildContext context, int workerId) async =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  WorkerProfileController(workerId: workerId)));

  static gotoSuperVisorProfile(BuildContext context, int supervisorId) async =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SuperVisorProfileController(superVisorId: supervisorId)));

  static gotoAddSuperVisor(BuildContext context, bool iscomeFromHomeScreen,
          {int superVisorid = 0}) async =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddSuperVisorController(
                    iscomeFromHomeScreen: iscomeFromHomeScreen,
                    superVisiorId: superVisorid,
                  )));

  static gotoAddSite(BuildContext context, bool iscomeFromHomeScreen,
          {int siteId = 0}) async =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddSiteLocationController(
                    iscomeFromHomeScreen: iscomeFromHomeScreen,
                    siteId: siteId,
                  )));

  // static gotoAddSuperVisor(BuildContext context) async => Navigator.push(
  //     context, MaterialPageRoute(builder: (context) => AddSuperVisorController()));

  static gotoAllSuperVisor(BuildContext context) async => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlSuperVisorController()));

  static gotoWorkerSiteScreen(BuildContext context, int siteId) async =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddWorkerSiteController(
                    siteId: siteId,
                  )));
}
