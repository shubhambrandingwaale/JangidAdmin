// To parse this JSON data, do
//
//     final allAttendanceWorker = allAttendanceWorkerFromJson(jsonString);

import 'dart:convert';

List<AllAttendanceWorker> allAttendanceWorkerFromJson(String str) =>
    List<AllAttendanceWorker>.from(
        json.decode(str).map((x) => AllAttendanceWorker.fromJson(x)));

String allAttendanceWorkerToJson(List<AllAttendanceWorker> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllAttendanceWorker {
  int id;
  String hours;
  DateTime checkIn;
  DateTime checkOut;
  int workerId;
  int earned;
  String timeDiff;
  DateTime createdAt;
  dynamic siteId;
  dynamic siteName;

  AllAttendanceWorker({
    required this.id,
    required this.hours,
    required this.timeDiff,
    required this.checkIn,
    required this.checkOut,
    required this.workerId,
    required this.earned,
    required this.createdAt,
    required this.siteId,
    required this.siteName,
  });

  factory AllAttendanceWorker.fromJson(Map<String, dynamic> json) =>
      AllAttendanceWorker(
        id: json["id"] ?? 0,
        hours: json["hours"] ?? "",
        checkIn: DateTime.parse(json["check_in"]),
        checkOut: DateTime.parse(json["check_out"]),
        workerId: json["worker_id"] ?? 0,
        earned: json["earned"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        siteId: json["site_id"],
        timeDiff: json["time_diff"] ?? "",
        siteName: json["site_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hours": hours,
        "check_in": checkIn.toIso8601String(),
        "check_out": checkOut.toIso8601String(),
        "worker_id": workerId,
        "earned": earned,
        "created_at": createdAt.toIso8601String(),
        "site_name": siteName,
        "time_Diff": timeDiff
      };
}
