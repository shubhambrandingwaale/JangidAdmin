import 'dart:convert';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/workers/model/AttendanceWorker.dart';
import 'package:attendance_admin/ui/workers/model/SiteModel.dart';
import 'package:attendance_admin/ui/workers/model/WorkerModelIndividual.dart';
import 'package:attendance_admin/utility/Api.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:attendance_admin/widgets/ToastBar.dart';
import 'package:flutter/material.dart';

class WorkerProfileRepository with ChangeNotifier {
  String error = "";
  Status _status = Status.Uninitialized;
  Status get status => _status;

/////////////////////////// create Model Variable ////////////////////////////////////

  TextEditingController nameController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController dailyWagesController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController contactNumberController = new TextEditingController();

  List<Myfile> myfiles = [];

  var siteAssigned;
  SiteModel get siteData => _siteData;
  List<SiteDataList> siteListData = [];
  var _siteData;
  bool isDropdownEnable = true;

  WorkerIndividual get individualworkerData => _individualworkerData;
  Worker? workerIndividualData;
  var _individualworkerData;

  var selectedSite;
  var selectedSiteId;
  final siteList = [];
  String btnText = 'Unassign';

  List<AllAttendanceWorker> attendanceList = [];

  String Choosevalue = 'Site1';
  final li = [
    'Site1',
    'Site2',
    'Site3',
    'Site4',
  ];
/////////////////////////// API Calling ////////////////////////////////////

  Future<bool> getAllSite(BuildContext context) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.allSites;
    String token = await Util.gettoken();
    final response = await Api.getrequest(url, context, token: token);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("getProfile in json: $json");
        error = '';
        if (json['message'] == 'success') {
          _status = Status.Authenticated;
          _siteData = SiteModel.fromJson(json);
          siteListData = siteData.data;
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

  Future<bool> getWorkerById(BuildContext context, int workerId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addWorker;
    var keys = {"worker_id": workerId};
    final response = await Api.getrequestwithbody(url, context, keys);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("getProfile in json: $json");
        error = '';
        if (json['message'] == 'success') {
          _status = Status.Authenticated;
          _individualworkerData = WorkerIndividual.fromJson(json);
          workerIndividualData = individualworkerData.worker;
          selectedSiteId = workerIndividualData!.siteAssigned;
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

  Future<bool> getAttendanceById(BuildContext context, int workerId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.attendance;
    var keys = {"worker_id": workerId};
    final response = await Api.getrequestwithbody(url, context, keys);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("getProfile in json: $json");
        error = '';
        _status = Status.Authenticated;
        attendanceList = allAttendanceWorkerFromJson(response);
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

  Future<bool> UpdateSiteAssign(BuildContext context, int workerId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.siteAssign;
    var keys = {"site_id": selectedSiteId, "worker_id": workerId};
    final response = await Api.PutsAPI(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        error = '';
        if (json['message'] == 'Site assigned.') {
          _status = Status.Authenticated;
          Routesapp.gotoWorkerProfile(context, workerId);
          Util.showmessagebar(context, json['message']);
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

  void isdropdownEnable(BuildContext context, int workerId) {
    if (btnText == 'Unassign') {
      isDropdownEnable = false;
      btnText = 'Assign';
      notifyListeners();
    } else {
      isDropdownEnable = true;
      btnText = 'Unassign';
      UpdateSiteAssign(context, workerId);
      notifyListeners();
    }
  }

  changeSiteId(String? siteId) {
    selectedSiteId = siteId ?? '';
    notifyListeners();
  }
}
