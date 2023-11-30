// To parse this JSON data, do
//
//     final workerModel = workerModelFromJson(jsonString);

import 'dart:convert';

WorkerModel workerModelFromJson(String str) =>
    WorkerModel.fromJson(json.decode(str));

String workerModelToJson(WorkerModel data) => json.encode(data.toJson());

class WorkerModel {
  String message;
  int status;
  List<WorkerDataList> data;

  WorkerModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) => WorkerModel(
        message: json["message"] ?? "",
        status: json["status"] ?? 0,
        data: List<WorkerDataList>.from(
            json["data"].map((x) => WorkerDataList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class WorkerDataList {
  int id;
  String fullname;
  String phone;
  String role;
  List<String> docs;
  String? profileImg;
  String username;
  String password;
  String hpassword;
  dynamic supervisorId;
  String siteAssigned;
  int dailyWageSalary;
  bool isPresent;
  bool isDisabled;
  int totalWorkingHours;
  int totalPayout;
  int totalPaid;
  int pendingPayout;
  String? lat;
  String? long;
  DateTime createdAt;
  DateTime updatedAt;
  String? address;

  WorkerDataList({
    required this.id,
    required this.fullname,
    required this.phone,
    required this.role,
    required this.docs,
    required this.profileImg,
    required this.username,
    required this.password,
    required this.hpassword,
    required this.supervisorId,
    required this.siteAssigned,
    required this.dailyWageSalary,
    required this.isPresent,
    required this.isDisabled,
    required this.totalWorkingHours,
    required this.totalPayout,
    required this.totalPaid,
    required this.pendingPayout,
    required this.lat,
    required this.long,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
  });

  factory WorkerDataList.fromJson(Map<String, dynamic> json) => WorkerDataList(
        id: json["id"] ?? 0,
        fullname: json["fullname"] ?? "",
        phone: json["phone"] ?? "",
        role: json["role"] ?? "",
        docs: json["docs"] == null
            ? []
            : List<String>.from(json["docs"].map((x) => x)),
        profileImg: json["profile_img"] ?? "",
        username: json["username"] ?? "",
        password: json["password"] ?? "",
        hpassword: json["hpassword"] ?? "",
        supervisorId: json["supervisor_id"],
        siteAssigned: json["site_assigned"] ?? "",
        dailyWageSalary: json["daily_wage_salary"] ?? 0,
        isPresent: json["is_present"] ?? false,
        isDisabled: json["is_disabled"] ?? false,
        totalWorkingHours: json["total_working_hours"] ?? 0,
        totalPayout: json["total_payout"] ?? 0,
        totalPaid: json["total_paid"] ?? 0,
        pendingPayout: json["pending_payout"] ?? 0,
        lat: json["lat"] ?? "",
        long: json["long"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        address: json["address"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "phone": phone,
        "role": role,
        "docs": List<dynamic>.from(docs.map((x) => x)),
        "profile_img": profileImg,
        "username": username,
        "password": password,
        "hpassword": hpassword,
        "supervisor_id": supervisorId,
        "site_assigned": siteAssigned,
        "daily_wage_salary": dailyWageSalary,
        "is_present": isPresent,
        "is_disabled": isDisabled,
        "total_working_hours": totalWorkingHours,
        "total_payout": totalPayout,
        "total_paid": totalPaid,
        "pending_payout": pendingPayout,
        "lat": lat,
        "long": long,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "address": address,
      };
}
