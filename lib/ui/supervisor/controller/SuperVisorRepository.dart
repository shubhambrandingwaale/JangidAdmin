import 'dart:convert';
import 'dart:io';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/supervisor/model/AllSuperVisorModel.dart';
import 'package:attendance_admin/ui/workers/model/SiteModel.dart';
import 'package:attendance_admin/utility/Api.dart';
import 'package:attendance_admin/utility/CustomFunctions.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:attendance_admin/utility/Util.dart';
import 'package:attendance_admin/widgets/ToastBar.dart';
import 'package:flutter/material.dart';

class SuperVisorRepository with ChangeNotifier {
  String error = "";
  Status _status = Status.Uninitialized;
  Status get status => _status;

  var selectedSiteId;
  String nameerror = '',
      userNameerror = '',
      passwordError = '',
      emailAddressError = '',
      phoneError = '';

  String supervisorIdBySite = '';
  List<Myfile> myfiles = [];
  bool isprofileupdateStart = false;
  bool isHide = true;
  bool isAddSuperVisor = false;
  AllSuperVisorModel get superVisorData => _superVisorData;
  List<SuperVisorDataList> superVisorListData = [];
  var _superVisorData;

  var listOfData;

  SiteModel get siteData => _siteData;
  List<SiteDataList> siteListData = [];
  var _siteData;

  TextEditingController amountController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailAddressController = new TextEditingController();
  TextEditingController contactNumberController = new TextEditingController();

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

  emailError(String Email) {
    if (Email.isEmpty) {
      emailAddressError = "Please enter email";
      notifyListeners();
    } else if (!Util.validateEmail(Email)) {
      emailAddressError = "Please enter valid email";
      notifyListeners();
    } else {
      emailAddressError = '';
      notifyListeners();
    }
  }

  Future<bool> addSupervisorValidation(
    BuildContext context,
    bool iscomeFromHome,
    String superVisorId,
    List<Myfile> myfile,
  ) async {
    userNameError(userNameController.text);
    emailError(emailAddressController.text);
    phoneNumberError(contactNumberController.text);
    NameError(nameController.text);
    PasswordError(passwordController.text);
    bool result = userNameerror.isEmpty &&
        nameerror.isEmpty &&
        phoneError.isEmpty &&
        emailAddressError.isEmpty &&
        passwordError.isEmpty;
    if (result) {
      return await iscomeFromHome
          ? AddSuperVisorDetails(context, myfile)
          : UpdateSuperVisorDetails(context, superVisorId);
    } else {
      return false;
    }
  }

/////////////////////////// API Calling ////////////////////////////////////

  Future<bool> AddSuperVisorDetails(
      BuildContext context, List<Myfile> file) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addsupervisor;
    var keys = {
      'fullname': nameController.text,
      'phone': contactNumberController.text,
      'password': passwordController.text,
      'username': userNameController.text,
      'email': emailAddressController.text,
      'site_assigned': selectedSiteId == null ? "" : selectedSiteId.toString()
    };
    final response = await Api.addMultiImage(file, context, url, keys: keys);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        error = '';
        if (json['message'] == 'Created') {
          _status = Status.Authenticated;
          Util.showmessagebar(context, json['message']);
          // Routesapp.gotoAllSuperVisor(context);
          isAddSuperVisor = true;
          supervisorIdBySite = json['supervisor_id'].toString();
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

  Future<bool> deleteImage(
      BuildContext context, String fileName, String superVisorID) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = '${Api.deleteImage}$fileName?type=supervisor';
    var keys = {"supervisor_id": superVisorID};
    final response = await Api.deleterequest(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("Image in json: $json");
        error = '';
        if (json['message'] == 'file deleted') {
          _status = Status.Authenticated;
          getSuperVisorById(context, int.parse(superVisorID));
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

  Future<bool> deleteSuperVisor(
      BuildContext context, String superVisorID) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addsupervisor;
    var keys = {"supervisor_id": superVisorID};
    final response = await Api.deleterequest(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        error = '';
        if (json['message'] == 'DELETED') {
          _status = Status.Authenticated;
          getAllSuperVisor(context);
          Util.showmessagebar(context, 'Supervisor Deleted Successfully');
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

  Future<bool> getAllSuperVisor(BuildContext context) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.supervisor;
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
          _superVisorData = AllSuperVisorModel.fromJson(json);
          superVisorListData = superVisorData.data;
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

  Future<bool> getSuperVisorById(
      BuildContext context, int superVisiorId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addsupervisor;
    String token = await Util.gettoken();
    var keys = {"supervisor_id": superVisiorId};
    final response = await Api.getrequestwithbody(url, context, keys);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("getProfile in json: $json");
        error = '';
        _status = Status.Authenticated;
        listOfData = jsonDecode(response);
        // workerIndividualData = individualworkerData.worker;
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

  Future<bool> UpdateWalletBalance(
      BuildContext context, String amount, int superVisorId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.wallet;
    var keys = {"supervisor_id": superVisorId, "amount": amount};
    // Myfile myfile = Myfile("file", file);
    final response = await Api.PutsAPI(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        error = '';
        if (json['message'] == 'UPDATED') {
          _status = Status.Authenticated;
          Routesapp.gotoSuperVisorProfile(context, superVisorId);
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

  Future<bool> UpdateDocuments(
      BuildContext context, List<Myfile> file, String supervisorId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = '${Api.updateSuperVisorDocuments}/$supervisorId';
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
          getSuperVisorById(context, int.parse(supervisorId));
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

  Future<bool> uploadPic(
      BuildContext context, File file, String id, bool isSentToList) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = '${Api.updateSuperVisorPic}$id';
    Myfile myfile = Myfile("file", file);
    // var keys={};
    final response = await Api.AddProfile(myfile, context, url);
    Customlog("profileUpload in json: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        if (json['message'] == "Profile updated") {
          Toastbar.showToast(msg: 'Image Uploaded Successfully');
          if (isSentToList) {
            Routesapp.gotoAllSuperVisor(context);
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

  Future<bool> UpdateSuperVisorDetails(
    BuildContext context,
    String superVisorId,
  ) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = '${Api.addsupervisor}/$superVisorId';
    var keys = {
      'fullname': nameController.text,
      'phone': contactNumberController.text,
      'password': passwordController.text,
      'username': userNameController.text,
      'email': emailAddressController.text,
      'site_assigned': selectedSiteId.toString()
    };
    // Myfile myfile = Myfile("file", file);
    final response = await Api.PutsAPI(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        error = '';
        if (json['message'] == 'UPDATED') {
          _status = Status.Authenticated;
          Util.showmessagebar(context, json['message']);
          Routesapp.gotoAllSuperVisor(context);
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
