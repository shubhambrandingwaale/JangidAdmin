// To parse this JSON data, do
//
//     final workerIndividual = workerIndividualFromJson(jsonString);

import 'dart:convert';

WorkerIndividual workerIndividualFromJson(String str) =>
    WorkerIndividual.fromJson(json.decode(str));

String workerIndividualToJson(WorkerIndividual data) =>
    json.encode(data.toJson());

class WorkerIndividual {
  int status;
  String message;
  Worker worker;

  WorkerIndividual({
    required this.status,
    required this.message,
    required this.worker,
  });

  factory WorkerIndividual.fromJson(Map<String, dynamic> json) =>
      WorkerIndividual(
        status: json["status"] ?? 0,
        message: json["message"] ?? "",
        worker: Worker.fromJson(json["worker"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "worker": worker.toJson(),
      };
}

class Worker {
  int id;
  String fullname;
  String phone;
  String role;
  List<dynamic> docs;
  dynamic profileImg;
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
  dynamic lat;
  dynamic long;
  DateTime createdAt;
  DateTime updatedAt;
  String address;

  Worker({
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

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["id"] ?? 0,
        fullname: json["fullname"] ?? "",
        phone: json["phone"] ?? "",
        role: json["role"] ?? "",
        docs: json["docs"] == null
            ? []
            : List<dynamic>.from(json["docs"].map((x) => x)),
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
        lat: json["lat"],
        long: json["long"],
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
