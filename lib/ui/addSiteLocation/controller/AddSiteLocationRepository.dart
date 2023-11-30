import 'dart:convert';
import 'dart:io';
import 'package:attendance_admin/routes/AppRoutes.dart';
import 'package:attendance_admin/ui/Location/model/SiteIndividualModel.dart';
import 'package:attendance_admin/ui/addSiteLocation/model/ImageModel.dart';
import 'package:attendance_admin/ui/addSiteLocation/model/SupervisorModel.dart';
import 'package:attendance_admin/ui/workers/view/AllWorkersList.dart';
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

class AddSiteLocationRepository with ChangeNotifier {
  String error = "";
  Status _status = Status.Uninitialized;
  Status get status => _status;

  bool isCompleted = false;
  bool isprofileupdateStart = false;
  bool serviceEnabled = false;
  bool isGPSEnabled = false;
  var comapnyAddress = '';
  var latitude, longtitude;
  ImageModel dummyData = ImageModel(data: []);
  var selectedValue;

  String sitenameerror = '',
      ownernameerror = '',
      startTimeError = '',
      endTimeError = '',
      addressError = '',
      phoneError = '',
      totalBudgetError = '';

  int supervisorId = 0;
  String selectedName = "";

  SiteIndividualModel get individualsiteData => _individualsiteData;
  Data? siteIndividualData;
  var _individualsiteData;

  SupervisorModel get supervisordata => _supervisorData;
  List<SupervisorListData> supervisorListData = [];
  var _supervisorData;
  bool isLocationFetched = false;

/////////////////////////// create Model Variable ////////////////////////////////////

  TextEditingController siteNameController = new TextEditingController();
  TextEditingController ownerNameController = new TextEditingController();
  TextEditingController startTimeController = new TextEditingController();
  TextEditingController endTimeController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController contactNumberController = new TextEditingController();
  TextEditingController totalBudgetController = new TextEditingController();

  siteNameError(String sitename) {
    if (sitename.isEmpty) {
      sitenameerror = "Please enter site name";
      notifyListeners();
    } else {
      sitenameerror = '';
      notifyListeners();
    }
  }

  ownerNameError(String ownerName) {
    if (ownerName.isEmpty) {
      ownernameerror = "Please enter owner name";
      notifyListeners();
    } else {
      ownernameerror = '';
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

  budgetError(String budget) {
    if (budget.isEmpty) {
      totalBudgetError = "Please enter total budget";
      notifyListeners();
    } else {
      totalBudgetError = '';
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

  checkGPSStatus() async {
    locator.Location location = locator.Location();
    await location.requestService();
    isGPSEnabled = await Geolocator.isLocationServiceEnabled();
    notifyListeners();
  }

  Future<bool> getCurrentLocation(BuildContext context) async {
    locator.Location location = locator.Location();
    final permission = await pe.Permission.location.request();
    if (permission == PermissionStatus.permanentlyDenied) {
      await Util.showmessagebar(context, 'Location is Mandatory',
          iserror: true);
      notifyListeners();
    }
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      return false;
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.high,
      );
      String a = await _getAddressFromLatLng(position);
      Customlog(a);
      notifyListeners();
      return true;
    }
  }

  Future<String> _getAddressFromLatLng(Position position) async {
    await geo
        .placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<geo.Placemark> placemarks) async {
      geo.Placemark place = placemarks[3];
      Customlog('Address is :$place');
      Customlog(' ${position.latitude}${position.longitude}');
      latitude = position.latitude;
      longtitude = position.longitude;
      isLocationFetched = true;
      comapnyAddress =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}';
      notifyListeners();
    }).catchError((e) {
      debugPrint(e);
      return '';
    });
    return '';
  }

/////////////////////////// API Calling ////////////////////////////////////

  Future<bool> addSiteValidation(
      BuildContext context, bool iscomeFromHome, String siteId,
      {File? file}) async {
    siteNameError(siteNameController.text);
    ownerNameError(ownerNameController.text);
    AddressError(addressController.text);
    phoneNumberError(contactNumberController.text);
    budgetError(totalBudgetController.text);
    bool result = sitenameerror.isEmpty &&
        ownernameerror.isEmpty &&
        addressError.isEmpty &&
        phoneError.isEmpty &&
        totalBudgetError.isEmpty;
    if (result) {
      return await iscomeFromHome
          ? AddSiteDetails(context, file!)
          : UpdateSiterDetails(context, siteId);
    } else {
      return false;
    }
  }

  Future<bool> UpdateSiterDetails(
    BuildContext context,
    String siteId,
  ) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addSite;
    var keys = {
      'site_name': siteNameController.text,
      'owner_name': ownerNameController.text,
      'address': addressController.text,
      'start_time': startTimeController.text,
      'end_time': endTimeController.text,
      'total_budget': totalBudgetController.text,
      'owner_contact': contactNumberController.text,
      'site_id': siteId,
    };
    // Myfile myfile = Myfile("file", file);
    final response = await Api.PutsAPI(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        error = '';
        if (json['message'] == 'Site updated') {
          _status = Status.Authenticated;
          Util.showmessagebar(context, json['message']);
          Routesapp.gotoMapPage(context, json['site_id'], false);
          // Routesapp.gotoAllSuperVisor(context);
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

  Future<bool> UpdateSiteIsCompleted(
    BuildContext context,
    String siteId,
  ) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addSite;
    var keys = {'site_id': siteId, 'is_completed': isCompleted};
    // Myfile myfile = Myfile("file", file);
    final response = await Api.PutsAPI(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("post worker in json: $json");
        error = '';
        if (json['message'] == 'Site updated') {
          _status = Status.Authenticated;
          Util.showmessagebar(context, json['message']);
          // Routesapp.gotoAllSuperVisor(context);
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

  Future<bool> getAllSupervisor(BuildContext context) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.supervisor;
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
          _supervisorData = SupervisorModel.fromJson(json);
          supervisorListData = supervisordata.data;
          var data = <Datum>[];
          for (int i = 0; i < supervisorListData.length; i++) {
            data.add(Datum(
                item: supervisorListData[i].fullname,
                image: supervisorListData[i].profileImg,
                id: supervisorListData[i].id));
          }
          dummyData = ImageModel(data: data);
          selectedValue = dummyData.toJson()["data"][0]["id"];
          Customlog(dummyData.toJson()["data"].runtimeType);
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

  Future<bool> AddSiteDetails(BuildContext context, File file) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addSite;
    Myfile myfile = Myfile("file", file);
    Customlog(myfile);
    var keys = {
      'site_name': siteNameController.text,
      'owner_name': ownerNameController.text,
      'address': addressController.text,
      'start_time': startTimeController.text,
      'end_time': endTimeController.text,
      'total_budget': totalBudgetController.text,
      'owner_contact': contactNumberController.text
    };
    final response = await Api.postRequest(url, keys, myfile, true, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("getProfile in json: $json");
        error = '';
        if (json['message'] == 'Site created') {
          _status = Status.Authenticated;
          Util.showmessagebar(context, json['message']);
          Routesapp.gotoMapPage(context, json['site_id'], true);
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

  Future<bool> UpdateSuperVisor(
      BuildContext context, String superVisorId, String siteId) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = '${Api.assignSuperVisor}/$siteId';
    var keys = {"supervisor_id": superVisorId};
    final response = await Api.PutsAPI(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        error = '';
        _status = Status.Authenticated;
        Util.showmessagebar(context, json['message']);
        Routesapp.viewAllSites(context);
        // Routesapp.gotoMapPage(context, json['site_id'], false);
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

  Future<bool> UpdateSiteLocation(BuildContext context, double radius,
      int siteId, bool isComeFromHome) async {
    _status = Status.Authenticating;
    notifyListeners();
    String url = Api.addSite;
    var keys = {
      "site_id": siteId,
      "lat": latitude,
      "long": longtitude,
      "radius": radius,
      // "supervisor_id": selectedValue
    };
    final response = await Api.PutsAPI(url, keys, context);
    Customlog("response: $response");
    if (response.isNotEmpty) {
      try {
        var json = jsonDecode(response);
        Customlog("getProfile in json: $json");
        error = '';
        if (json['message'] == 'Site updated') {
          _status = Status.Authenticated;
          Util.showmessagebar(context, json['message']);
          if (isComeFromHome) {
            Routesapp.gotoWorkerSiteScreen(context, siteId);
          } else {
            Routesapp.viewAllSites(context);
          }
          // Routesapp.viewAllSites(context);
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
}
