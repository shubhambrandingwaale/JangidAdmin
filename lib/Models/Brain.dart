import 'dart:convert';
import 'package:attendance_admin/Models/EndPoints.dart';
import 'package:attendance_admin/ui/supervisor/model/AllSuperVisorModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BrainCode {
  void Navigatorpush(BuildContext context, routes) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => routes));
  }

  void Navigatorpops(BuildContext context) {
    Navigator.pop(context);
  }

  void printdata() {
    print("data");
  }

  Future<String> login_supervisor(String username, password) async {
    var response;
    response = await http.post(Uri.parse(BASEURL().login),
        body: jsonEncode(
            {"username": username.toString(), "password": password.toString()}),
        headers: {'Content-Type': 'application/json'});

    String body = response.body;
    return body;
  }

  Future<http.Response> AllSites(sharepref) async {
    http.Response response;
    response = await http.get(Uri.parse(BASEURL().AllSites), headers: {
      'authorization': "Bearer " + sharepref.toString(),
      'Content-Type': 'application/json'
    });

    return response;
  }

  Future<String> Dashboard(sharepref) async {
    var response;
    response = await http.get(Uri.parse(BASEURL().Dashboard), headers: {
      'authorization': "Bearer " + sharepref.toString(),
      'Content-Type': 'application/json'
    });

    String body = response.body;
    return body;
  }

  Future<dynamic> Supervisorlist(sharepref) async {
    var response;
    response = await http.get(Uri.parse(BASEURL().supervisor), headers: {
      'authorization': "Bearer " + sharepref.toString(),
      'Content-Type': 'application/json'
    });

    String body = response.body;
    return body;
  }
}
