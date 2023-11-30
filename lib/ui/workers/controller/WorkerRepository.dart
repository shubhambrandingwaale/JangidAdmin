import 'dart:convert';
import 'dart:io';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/workers/model/SiteModel.dart';
import 'package:attendance_admin/ui/workers/model/WorkerModel.dart';
import 'package:attendance_admin/ui/workers/model/WorkerModelIndividual.dart';
import 'package:attendance_admin/utility/Api.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:attendance_admin/widgets/ToastBar.dart';
import 'package:flutter/material.dart';

class WorkerRepository with ChangeNotifier {
  String error = "";
  Status _status = Status.Uninitialized;
  Status get status => _status;
  bool isprofileupdateStart = false;
  bool isAddWorker = false;
  String workerIdBySite = '';

/////////////////////////// create Model Variable ////////////////////////////////////

  String nameerror = '',
      userNameerror = '',
      dailyWagesError = '',
      passwordError = '',
      addressError = '',
      phoneError = '';
  bool isHide = true;

  TextEditingController nameController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController dailyWagesController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController contactNumberController = new TextEditingController();

  List<Myfile> myfiles = [];

  SiteModel get siteData => _siteData;
  List<SiteDataList> siteListData = [];
  var _siteData;

  WorkerModel get workerData => _workerData;
  List<WorkerDataList> workerListData = [];
  var _workerData;

  WorkerIndividual get individualworkerData => _individualworkerData;
  Worker? workerIndividualData;
  var _individualworkerData;

  var selectedSite;
  var selectedSiteId;
  final siteList = [];

  onVisibiltyChange() {
    isHide = !isHide;
    notifyListeners();
  }

  NameError(String name) {
    if (name.isEmpty) {
      nameerror = "Please enter fullname";
      notifyListeners();
    } else {
      nameerror = '';
      notifyListeners();
    }
  }

  userNameError(String userName) {
    if (userName.isEmpty) {
      userNameerror = "Please enter UserName";
      notifyListeners();
    } else {
      userNameerror = '';
      notifyListeners();
    }
  }

  PasswordError(String password) {
    if (password.isEmpty) {
      passwordError = "Please enter Password";
      notifyListeners();
    } else {
      passwordError = '';
      notifyListeners();
    }
  }

  AddressError(String address) {
    if (address.isEmpty) {
      addressError = "Please enter address";
      notifyListeners();
    } else {
      addressError = '';
      notifyListeners();
    }
  }

  dailywagesError(String wages) {
    if (wages.isEmpty) {
      dailyWagesError = "Please enter Daily Wages";
      notifyListeners();
    } else {
      dailyWagesError = '';
      notifyListeners();
    }
  }

  phoneNumberError(String phone) {
    if (phone.isEmpty) {
      phoneError = "Please enter contact number";
      notifyListeners();
    } else if (!Util.validatePhoneNumber(phone)) {
      phoneError = "Please enter valid contact number";
      notifyListeners();
    } else {
      phoneError = '';
      notifyListeners();
    }
  }

/////////////////////////// API Calling ////////////////////////////////////

  Future<bool> addWorkerValidation(BuildContext context, List<Myfile> myfile,
      bool iscomeFromHome, String workerId) async {
    dailywagesError(dailyWagesController.text);
    userNameError(userNameController.text);
    AddressError(addressController.text);
    phoneNumberError(contactNumberController.text);
    NameError(nameController.text);
    PasswordError(passwordController.text);
    bool result = dailyWagesError.isEmpty &&
        userNameerror.isEmpty &&
        nameerror.isEmpty &&
        phoneError.isEmpty &&
        addressError.isEmpty &&
        passwordError.isEmpty;
    if (result) {
      return await iscomeFromHome
          ? AddWorkerDetails(context, myfile)
          : UpdateWorkerDetails(context, myfile, workerId);
    } else {
      return false;
    }
  }

  Future<bool> deleteImage(
      BuildContext context, String fileName, String workerId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = '${Api.deleteImage}$fileName?type=worker';
    var keys = {"worker_id": workerId};
    final response = await Api.deleterequest(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("Image in json: $json");
        error = '';
        if (json['message'] == 'file deleted') {
          _status = Status.Authenticated;
          getWorkerById(context, int.parse(workerId));
          Util.showmessagebar(context, 'Image Deleted Successfully');
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

  Future<bool> AddWorkerDetails(BuildContext context, List<Myfile> file) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addWorker;
    var keys = {
      'fullname': nameController.text,
      'phone': contactNumberController.text,
      'password': passwordController.text,
      'daily_wage_salary': dailyWagesController.text,
      'username': userNameController.text,
      'address': addressController.text,
      'site_assigned': selectedSiteId == null ? "" : selectedSiteId.toString()
    };
    final response = await Api.addMultiImage(file, context, url, keys: keys);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        error = '';
        if (json['message'] == 'CREATED') {
          _status = Status.Authenticated;
          Util.showmessagebar(context, json['message']);
          isAddWorker = true;
          workerIdBySite = json['worker_id'].toString();
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

  Future<bool> uploadPic(
      BuildContext context, File file, String id, bool isSentToList) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.uploadWorkerPic;
    Myfile myfile = Myfile("file", file);
    Customlog('id is : $id');
    var keys = {'worker_id': id};
    final response = await Api.AddProfile(myfile, context, url, keys: keys);
    Customlog("profileUpload in json: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        if (json['message'] == "Profile updated") {
          Toastbar.showToast(msg: 'Image Uploaded Successfully');
          if (isSentToList) {
            Routesapp.gotoWorkerListScreen(context);
          }
          _status = Status.Authenticated;
          notifyListeners();
          return true;
        } else {
          error = json['message'].toString();
          Util.showmessagebar(context, '$error', iserror: true);
          _status = Status.error;
          notifyListeners();
          return false;
        }
      } catch (e) {
        error = e.toString();
        Util.showmessagebar(context, "$e", iserror: true);
        _status = Status.error;
        notifyListeners();
        return false;
      }
    } else {
      _status = Status.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> UpdateDocuments(
      BuildContext context, List<Myfile> file, String workerId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = '${Api.updateWorkerDocuments}/$workerId';
    final response =
        await Api.addMultiImage(file, context, url, isPutApi: true);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        error = '';
        if (json['message'] == 'UPDATED') {
          _status = Status.Authenticated;
          getWorkerById(context, int.parse(workerId));
          Util.showmessagebar(context, json['message']);
          // Routesapp.gotoWorkerListScreen(context);
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

  Future<bool> UpdateWorkerDetails(
      BuildContext context, List<Myfile> file, String workerId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addWorker;
    var keys = {
      'fullname': nameController.text,
      'phone': contactNumberController.text,
      'password': passwordController.text,
      'daily_wage_salary': dailyWagesController.text,
      'username': userNameController.text,
      'address': addressController.text,
      'site_assigned': selectedSiteId.toString(),
      'worker_id': workerId
    };
    final response =
        await Api.addMultiImage(file, context, url, keys: keys, isPutApi: true);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        error = '';
        if (json['message'] == 'UPDATED') {
          _status = Status.Authenticated;
          Util.showmessagebar(context, json['message']);
          Routesapp.gotoWorkerListScreen(context);
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

  Future<bool> deleteWorker(BuildContext context, String workerID) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addWorker;
    var keys = {"worker_id": workerID};
    final response = await Api.deleterequest(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        error = '';
        if (json['message'] == 'DELETED') {
          _status = Status.Authenticated;
          getAllWorkerList(context);
          Util.showmessagebar(context, 'Worker Deleted Successfully');
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

  Future<bool> getAllWorkerList(BuildContext context) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.allWorkers;
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
          _workerData = WorkerModel.fromJson(json);
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

  Future<bool> getWorkerById(BuildContext context, int workerId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addWorker;
    String token = await Util.gettoken();
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
