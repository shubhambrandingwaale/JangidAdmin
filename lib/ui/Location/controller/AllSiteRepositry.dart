import 'dart:convert';
import 'dart:io';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/Location/model/AllSiteModel.dart';
import 'package:attendance_admin/ui/Location/model/SiteIndividualModel.dart';
import 'package:attendance_admin/ui/addSiteLocation/model/ImageModel.dart';
import 'package:attendance_admin/ui/addSiteLocation/model/SupervisorModel.dart';
import 'package:attendance_admin/utility/Api.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:attendance_admin/widgets/ToastBar.dart';
import 'package:flutter/material.dart';

class AddSiteRepository with ChangeNotifier {
  String error = "";
  Status _status = Status.Uninitialized;
  Status get status => _status;

  AllsiteModel get sitedata => siteData;
  List<AllSiteDataList> siteListData = [];
  var siteData;

  SiteIndividualModel get individualsiteData => _individualsiteData;
  Data? siteIndividualData;
  var _individualsiteData;

/////////////////////////// API Calling ////////////////////////////////////

  Future<bool> getAllSite(BuildContext context) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.allSites;
    String token = await Util.gettoken();
    final responce = await Api.getrequest(url, context, token: token);
    Customlog("response: $responce");
    if (responce.isNotEmpty) {
      try {
        var json = jsonDecode(responce);
        Customlog("getProfile in json: $json");
        error = '';
        if (json['message'] == 'success') {
          _status = Status.Authenticated;
          siteData = AllsiteModel.fromJson(json);
          siteListData = sitedata.data;
          notifyListeners();
          return true;
        } else {
          _status = Status.Authenticated;
          Toastbar.showToast(msg: json['error']);
          _status = Status.error;
          notifyListeners();
          return false;
        }
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

  Future<bool> getSiteById(BuildContext context, int siteId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addSite;
    String token = await Util.gettoken();
    var keys = {"site_id": siteId};
    final response = await Api.getrequestwithbody(url, context, keys);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("getProfile in json: $json");
        error = '';
        _status = Status.Authenticated;
        _individualsiteData = SiteIndividualModel.fromJson(json);
        siteIndividualData = individualsiteData.data;
        notifyListeners();
        return true;
      } catch (e) {
        _status = Status.Authenticated;
        error = e.toString();
        Toastbar.showToast(msg: error);
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

  Future<bool> deleteSite(BuildContext context, String siteID) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addSite;
    var keys = {"site_id": siteID};
    final response = await Api.deleterequest(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        error = '';
        if (json['message'] == 'Site deleted') {
          _status = Status.Authenticated;
          getAllSite(context);
          Util.showmessagebar(context, 'Site Deleted Successfully');
          notifyListeners();
          return true;
        } else {
          _status = Status.Authenticated;
          Toastbar.showToast(msg: json['message']);
          _status = Status.error;
          notifyListeners();
          return false;
        }
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
