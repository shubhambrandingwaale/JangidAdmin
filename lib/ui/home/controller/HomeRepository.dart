import 'dart:convert';
import 'package:attendance_admin/ui/home/model/PresentWorkerModel.dart';
import 'package:attendance_admin/utility/Api.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:attendance_admin/widgets/ToastBar.dart';
import 'package:flutter/material.dart';

import '../../../utility/CustomFunctions.dart';

class HomeRepository with ChangeNotifier {
  String error = "";
  Status _status = Status.Uninitialized;
  Status get status => _status;

  TextEditingController startTimeController = new TextEditingController();

  PresentWorkerModel get workerData => _workerData;
  List<PresentWorkerData> workerListData = [];
  var _workerData;

  Future<bool> PunchOut(BuildContext context, String sessionId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.punchOut;
    // String punchOut=Util.getCurrentDate();
    var keys = {
      "session_id": sessionId,
      "punch_out_time": startTimeController.text
    };
    final response = await Api.postrequest(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        if (json['message'] == 'Logged out') {
          error = '';
          _status = Status.Authenticated;
          getPresentWorker(context);
          Util.showmessagebar(context, 'Punch-Out Successfully');
          // Routesapp.gotoWorkerListScreen(context);
          notifyListeners();
          return true;
        } else {
          error = '';
          _status = Status.Authenticated;
          Util.showmessagebar(context, json['message'], iserror: true);
          notifyListeners();
          return true;
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

  Future<bool> getPresentWorker(BuildContext context) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.workerPunchIn;
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
          _workerData = PresentWorkerModel.fromJson(json);
          workerListData = workerData.data;
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
}
