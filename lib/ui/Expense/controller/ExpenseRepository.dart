import 'dart:convert';
import 'dart:io';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/Expense/model/ExpenseModel.dart';
import 'package:attendance_admin/ui/addSiteLocation/model/ImageModel.dart';
import 'package:attendance_admin/ui/addSiteLocation/model/SupervisorModel.dart';
import 'package:attendance_admin/utility/Api.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:attendance_admin/widgets/ToastBar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:location/location.dart' as locator;
import 'package:permission_handler/permission_handler.dart' as pe;
import 'package:permission_handler/permission_handler.dart';

class ExpenseRepository with ChangeNotifier {
  String error = "";
  Status _status = Status.Uninitialized;
  Status get status => _status;


  List<ExpenseModel> expenseList = [];
  // AllsiteModel get sitedata => siteData;
  // List<AllSiteDataList> siteListData = [];
  // var siteData;

/////////////////////////// API Calling ////////////////////////////////////

  Future<bool> getExpenseList(BuildContext context) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.expense;
    String token=await Util.gettoken();
    final response = await Api.getrequest(url, context,token:token );
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("getProfile in json: $json");
        error = '';
        _status = Status.Authenticated;
        expenseList = expenseModelFromJson(response);
        notifyListeners();
        return true;
      } catch (e) {
        _status = Status.Authenticated;
        error = e.toString();
        _status = Status.error;
        notifyListeners();
        return false;
      }
    } else {
      _status = Status.Authenticated;
      _status = Status.error;
      notifyListeners();
      return false;
    }
  }
}
