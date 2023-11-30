import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'CustomFunctions.dart';
import 'Util.dart';
import 'package:http_parser/http_parser.dart';

class Api {
  static String baseurl = "https://jangid.nlaolympiad.in/api/";
  static String addSite = "sites";
  static String supervisor = "supervisors/all";
  static String addsupervisor = "supervisors";
  static String wallet = "wallets";
  static String addWorker = "workers";
  static String allSites = "sites/all";
  static String assignSuperVisor = "supervisors/site-assign";
  static String allWorkers = "workers/all";
  static String attendance = "attendances";
  static String siteAssign = "workers/site-assign";
  static String expense = "expenses/all";
  static String uploadWorkerPic = "workers/update-profile";
  static String updateSuperVisorPic = "supervisors/update-profile/";
  static String updateWorkerDocuments = "workers/upload-docs";
  static String updateSuperVisorDocuments = "supervisors/upload-docs";
  static String deleteImage = "files";
  static String workerPunchIn = "workers/punched-in";
  static String punchOut = "auth/worker/check-out";

  static Future<String> postLogin(
      String apiname, var keys, BuildContext context) async {
    var url = Uri.parse(baseurl + apiname);
    print('post bodyurl=> $url');
    print('post body=> $keys');
    String token = await Util.gettoken();
    int midIndex = token.length ~/ 2;
    String part1 = token.substring(0, midIndex);
    String part2 = token.substring(midIndex);
    var headers = {
      'Content-Type': 'application/json',
      "Authorization": part1,
      'Cookie': 'token=$part2',
    };
    try {
      var request = http.Request('POST', Uri.parse('$baseurl' "$apiname"));
      request.body = json.encode(keys);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var data = await response.stream.bytesToString();
      Customlog("res for new $data");
      if (response.statusCode != 500) {
        return data;
      } else {
        return data;
      }
    } catch (e) {
      // print(e.toString());
      CustomPrint(e.toString());
      return e.toString();
    }
  }

  static Future<String> postLoginForVerifyPayment(
      String apiname, var keys) async {
    var url = Uri.parse(baseurl + apiname);
    // String body = json.encode(keys);
    print('post bodyurl=> $url');
    print('post body=> $keys');
    String token = await Util.gettoken();
    int midIndex = token.length ~/ 2;
    String part1 = token.substring(0, midIndex);
    String part2 = token.substring(midIndex);
    var headers = {
      'Content-Type': 'application/json',
      "Authorization": part1,
      'Cookie': 'token=$part2',
    };
    try {
      var request = http.Request('POST', Uri.parse('$baseurl' "$apiname"));
      request.body = json.encode(keys);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var data = await response.stream.bytesToString();
      Customlog("res for new $data");
      if (response.statusCode != 500) {
        return data;
      } else {
        return data;
      }
    } catch (e) {
      CustomPrint(e.toString());
      return e.toString();
    }
  }

  //for search Places Api
  Future<String?> fetchPlacesApi(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      return e.toString();
    }
  }

  // post request
  static Future<String> postrequest3(
      String apiname, var keys, bool auth, BuildContext context) async {
    var url = Uri.parse(baseurl + apiname);
    // String body = json.encode(keys);
    print('post bodyurl=> $url');
    print('post body=> $keys');
    String token = await Util.gettoken();
    var sendbody = json.encode(keys);
    Customlog('post token=> $token');
    try {
      var response = await http.post(url,
          headers: {"authorization": "Bearer $token"}, body: sendbody);
      // print(response.body);
      Customlog(response.body.toString());
      if (response.body.isNotEmpty) {
        return response.body.toString();
      } else {
        // print('${response.statusCode} api status');
        Customlog(
            '${response.statusCode} api response code which is not consider for authentication !!');
        return "";
      }
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  static Future<String> postRequest(
      String apiname, var keys, Myfile file, bool auth, BuildContext context,
      {bool isPutApi = false}) async {
    // String body = json.encode(keys);
    print('post body=> $keys');
    String token = await Util.gettoken();
    var sendbody = json.encode(keys);
    Customlog('post token=> $token');
    try {
      var url = Uri.parse(baseurl + apiname);
      var headers = {'Authorization': 'Bearer $token'};
      var request =
          http.MultipartRequest(isPutApi ? 'PUT' : 'POST', Uri.parse('$url'));
      request.fields.addAll(keys);
      request.files.add(await http.MultipartFile.fromPath(
          'file', file.file.path,
          contentType: MediaType('application', 'image')));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var data = await response.stream.bytesToString();
      return data;
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  static Future<String> deleterequest(
      String apiname, var keys, BuildContext context) async {
    var url = Uri.parse(baseurl + apiname);
    // String body = json.encode(keys);
    print('post bodyurl=> $url');
    print('post body=> $keys');
    String token = await Util.gettoken();

    Customlog('post token=> $token');
    try {
      var response = await http.delete(url,
          headers: {'authorization': 'Bearer $token'}, body: keys);
      Customlog(response.body.toString());
      if (response.body.isNotEmpty) {
        return response.body.toString();
      } else {
        Customlog(
            '${response.statusCode} api response code which is not consider for authentication !!');
        return "";
      }
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static Future<String> postrequest(
      String api, var keys, BuildContext context) async {
    try {
      String token = await Util.gettoken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token '};
      var request = http.Request('POST', Uri.parse('$baseurl' "$api"));
      request.body = json.encode(keys);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var data = await response.stream.bytesToString();
      return data;
    } catch (e) {
      CustomPrint(e.toString());
      return e.toString();
    }
  }


  static Future<String> PutsAPI(
      String api, var keys, BuildContext context) async {
    String token = await Util.gettoken();
    CustomPrint(keys);
    CustomPrint("token=> $token");
    Uri url = Uri.parse("$baseurl$api");
    Customlog("Url=> $url");
    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('PUT', url);
      request.body = json.encode(keys);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode >= 200) {
        return await response.stream.bytesToString();
      } else {
        throw Exception('Failed to update address.');
      }
      // make PUT request
    } catch (e) {
      // print(e.toString());
      CustomPrint(e.toString());
      return e.toString();
    }
  }

  static Future<String> addMultiImage(
      List<Myfile> file, context, String APIName,
      {var keys, bool isPutApi = false}) async {
    String url;
    url = baseurl + APIName;

    String token = await Util.gettoken();
    print('post bodyurl=> $url');
    var headers = {
      'Content-Type': 'application/json',
      "authorization": "Bearer $token"
    };

    var request =
        http.MultipartRequest(isPutApi ? 'PUT' : 'POST', Uri.parse(url));
    request.headers.addAll(headers);
    if (keys != null) {
      request.fields.addAll(keys);
    }
    if (file != null) {
      for (var element in file) {
        String fileExtension = element.file.path.split('.').last;
        String mediaType = 'image/$fileExtension';
        if (element.filekey.isNotEmpty) {
          request.files.add(await http.MultipartFile.fromPath(
              element.filekey, element.file.path,
              contentType: MediaType.parse(mediaType)));
        }
      }
    }
    http.StreamedResponse response = await request.send();
    var responce2 = await response.stream.bytesToString();
    return responce2;
  }

  static Future<String> update(
      String api, var keys, BuildContext context) async {
    String jwtToken = await Util.gettoken();
    int midIndex = jwtToken.length ~/ 2;
    String part1 = jwtToken.substring(0, midIndex);
    String part2 = jwtToken.substring(midIndex);
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'token=$part2',
      "Authorization": part1
    };
    var request = http.Request('PUT', Uri.parse(baseurl + api));
    request.body = jsonEncode(keys);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return await response.stream.bytesToString();
  }

  static Future<String> updateUsingPatch(
      String api, var keys, BuildContext context) async {
    String jwtToken = await Util.gettoken();
    int midIndex = jwtToken.length ~/ 2;
    String part1 = jwtToken.substring(0, midIndex);
    String part2 = jwtToken.substring(midIndex);
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'token=$part2',
      "Authorization": part1
    };
    // if(token.isNotEmpty){
    //   headers.addAll({'Authorization': 'Bearer $token'});
    // }
    var request = http.Request('PATCH', Uri.parse(baseurl + api));
    request.body = jsonEncode(keys);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return await response.stream.bytesToString();
  }

  static Future<String> postrequest2(
      String api, var keys, bool auth, BuildContext context) async {
    String token = await Util.gettoken();
    // print(keys);
    CustomPrint("PostRequest2 : " + api);
    var headers = {
      'Content-Type': 'application/json',
      'apikey': '412034928eb0d2-24f3-4317-9628-bca5cb59ab00'
    };
    try {
      var request = http.Request(
          'POST', Uri.parse('https://apitest.tripjack.com/' "$api"));
      request.body = json.encode(keys);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // Customlog("response in APi File: " + response.toString());
      // Customlog("res for new $response");
      if (response.statusCode != 500) {
        return response.stream.bytesToString();
      } else {
        // print('${response.statusCode} api status');
        Customlog(
            '${response.statusCode} api responce code which is not consider for autication !!');
        return "";
      }
    } catch (e) {
      // print(e.toString());
      CustomPrint(e.toString());
      return e.toString();
    }
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static Future<String> AddProfile(
      Myfile file, BuildContext context, String APIName,
      {var keys}) async {
    String url;
    url = baseurl + APIName;

    String token = await Util.gettoken();
    print('post bodyurl=> $url');
    try {
      String jwtToken = await Util.gettoken();
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      if (keys != null) {
        request.fields.addAll(keys);
      }
      var headers = {'Authorization': 'Bearer $jwtToken'};
      request.headers.addAll(headers);
      request.files.add(await http.MultipartFile.fromPath(
          'file', file.file.path,
          contentType: MediaType('application', 'image')));

      http.StreamedResponse response = await request.send();
      var responce2 = await response.stream.bytesToString();
      return responce2;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> loginrequest(
      String apiname, var keys, bool auth, BuildContext context) async {
    var url = Uri.parse(baseurl + apiname);
    // String body = json.encode(keys);
    print('login post bodyurl=> $url');
    try {
      var response = await http.post(url, body: keys);
      // print(response.body);
      if (response.statusCode == 200) {
        return response.body.toString();
      } else {
        // print('${response.statusCode} api status');
        Customlog(
            '${response.statusCode} api responce code which is not consider for authentication !!');
        return "";
      }
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  static Future<String> getrequestwithbody(
      String apiname, BuildContext context, var keys) async {
    try {
      String token = await Util.gettoken();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse(baseurl + apiname));
      request.body = json.encode(keys);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final data = await response.stream.bytesToString();
      return data;
    } catch (e) {
      return e.toString();
    }
  }

  //get request with token
  static Future<String> getrequest(String apiname, BuildContext context,
      {String token = ''}) async {
    var url = Uri.parse("$baseurl$apiname");
    Customlog("$apiname: $url");
    CustomPrint(token);
    var headers = {'Authorization': 'Bearer $token'};
    try {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var data = await response.stream.bytesToString();
      return data;
    } catch (e) {
      // print('issue inside request');
      return e.toString();
    }
  }

  static Future<http.Response> getUserDetails(
      String apiName, String url, int userId, BuildContext context) async {
    try {
      final finalUrl = Uri.parse('$url$apiName/$userId');
      final response = await http.get(finalUrl);
      return response;
    } catch (e) {
      Customlog('Error $e');
      throw Exception('Failed to Fetch User Details');
    }
  }

  static Future<http.Response?> createMessageRoom({
    required String apiName,
    required String url,
    required int senderId,
    required int receiverId,
  }) async {
    try {
      final requestBody = {"senderId": senderId, "receiverId": receiverId};
      final finalUrl = Uri.parse('$url$apiName');
      final headers = {'Content-Type': 'application/json'};

      final response = await http.post(finalUrl,
          headers: headers, body: json.encode(requestBody));
      return response;
    } catch (e) {
      Customlog('Error1 $e');
      return null;
    }
  }

  static Future<http.Response?> sendMessage(
      {required int senderId,
      required int receiverId,
      required String chatRoomId,
      String? message,
      required String msgType,
      required String apiName,
      required String url,
      String? file}) async {
    try {
      final finalUrl = Uri.parse('$url$apiName');
      var map = <String, dynamic>{};

      if (msgType == 'Text'.toLowerCase()) {
        map['senderId'] = senderId.toString();
        map['receiverId'] = receiverId.toString();
        map['message'] = message;
        map['msgType'] = msgType;
        map['chatRoomId'] = chatRoomId;
        http.Response response = await http.post(finalUrl, body: map);
        return response;
      }

      if (msgType == 'file' && file != null) {
        http.MultipartRequest request = http.MultipartRequest('POST', finalUrl);
        request.fields['senderId'] = senderId.toString();
        request.fields['receiverId'] = receiverId.toString();
        request.fields['msgType'] = 'file';
        request.fields['chatRoomId'] = chatRoomId;
        request.files.add(await http.MultipartFile.fromPath('file', file,
            contentType: MediaType('application', 'image')));
        http.StreamedResponse streamedResponse = await request.send();
        http.Response response =
            await http.Response.fromStream(streamedResponse);
        return response;
      }
    } catch (e) {
      Customlog('Error in Send Message $e');
      return null;
    }
  }
}

class Myfile {
  late String filekey;
  late File file;
  Myfile(this.filekey, this.file);
}
