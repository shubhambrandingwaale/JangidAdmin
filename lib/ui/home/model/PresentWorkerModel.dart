// To parse this JSON data, do
//
//     final presentWorkerModel = presentWorkerModelFromJson(jsonString);

import 'dart:convert';

PresentWorkerModel presentWorkerModelFromJson(String str) =>
    PresentWorkerModel.fromJson(json.decode(str));

String presentWorkerModelToJson(PresentWorkerModel data) =>
    json.encode(data.toJson());

class PresentWorkerModel {
  String message;
  int status;
  List<PresentWorkerData> data;

  PresentWorkerModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory PresentWorkerModel.fromJson(Map<String, dynamic> json) =>
      PresentWorkerModel(
        message: json["message"] ?? "",
        status: json["status"] ?? 0,
        data: json["data"] == null
            ? []
            : List<PresentWorkerData>.from(
                json["data"].map((x) => PresentWorkerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PresentWorkerData {
  String uid;
  DateTime date;
  DateTime checkIn;
  dynamic checkOut;
  int workerId;
  DateTime createdAt;
  int siteId;
  String workerUsername;
  String workerFullname;
  String profileImg;

  PresentWorkerData({
    required this.uid,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.workerId,
    required this.profileImg,
    required this.createdAt,
    required this.siteId,
    required this.workerUsername,
    required this.workerFullname,
  });

  factory PresentWorkerData.fromJson(Map<String, dynamic> json) =>
      PresentWorkerData(
        uid: json["uid"] ?? "",
        date: DateTime.parse(json["date"]),
        checkIn: DateTime.parse(json["check_in"]),
        checkOut: json["check_out"],
        workerId: json["worker_id"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        siteId: json["site_id"] ?? 0,
        workerUsername: json["worker_username"] ?? "",
        workerFullname: json["worker_fullname"] ?? "",
        profileImg: json["profile_img"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "date": date.toIso8601String(),
        "check_in": checkIn.toIso8601String(),
        "check_out": checkOut,
        "worker_id": workerId,
        "created_at": createdAt.toIso8601String(),
        "site_id": siteId,
        "worker_username": workerUsername,
        "worker_fullname": workerFullname,
        "profile_img": profileImg
      };
}
