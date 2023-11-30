// To parse this JSON data, do
//
//     final siteIndividualModel = siteIndividualModelFromJson(jsonString);

import 'dart:convert';

SiteIndividualModel siteIndividualModelFromJson(String str) =>
    SiteIndividualModel.fromJson(json.decode(str));

String siteIndividualModelToJson(SiteIndividualModel data) =>
    json.encode(data.toJson());

class SiteIndividualModel {
  String message;
  int status;
  Data data;

  SiteIndividualModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory SiteIndividualModel.fromJson(Map<String, dynamic> json) =>
      SiteIndividualModel(
        message: json["message"] ?? "",
        status: json["status"] ?? 0,
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String siteName;
  String ownerName;
  String ownerContact;
  String address;
  String image;
  int totalBudget;
  int budgetLeft;
  bool isCompleted;
  String startTime;
  String endTime;
  String lat;
  String long;
  int radius;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic supervisorId;
  String totalWorkers;
  String presentWorkers;
  String totalTransactions;
  List<Payout> sitePayouts;
  List<Payout> workerPayouts;
  List<Worker> workers;

  Data({
    required this.id,
    required this.siteName,
    required this.ownerName,
    required this.ownerContact,
    required this.address,
    required this.image,
    required this.totalBudget,
    required this.budgetLeft,
    required this.isCompleted,
    required this.startTime,
    required this.endTime,
    required this.lat,
    required this.long,
    required this.radius,
    required this.createdAt,
    required this.updatedAt,
    required this.supervisorId,
    required this.totalWorkers,
    required this.presentWorkers,
    required this.totalTransactions,
    required this.sitePayouts,
    required this.workerPayouts,
    required this.workers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? 0,
        siteName: json["site_name"] ?? "",
        ownerName: json["owner_name"] ?? "",
        ownerContact: json["owner_contact"] ?? "",
        address: json["address"] ?? "",
        image: json["image"] ?? "",
        totalBudget: json["total_budget"] ?? 0,
        budgetLeft: json["budget_left"] ?? 0,
        isCompleted: json["is_completed"] ?? false,
        startTime: json["start_time"] ?? "",
        endTime: json["end_time"] ?? "",
        lat: json["lat"] ?? "",
        long: json["long"] ?? "",
        radius: json["radius"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        supervisorId: json["supervisor_id"],
        totalWorkers: json["total_workers"],
        presentWorkers: json["present_workers"] ?? "",
        totalTransactions: json["total_transactions"] ?? "",
        sitePayouts: json["site_payouts"] == null
            ? []
            : List<Payout>.from(
                json["site_payouts"].map((x) => Payout.fromJson(x))),
        workerPayouts: json["worker_payouts"] == null
            ? []
            : List<Payout>.from(
                json["worker_payouts"].map((x) => Payout.fromJson(x))),
        workers: json["workers"] == null
            ? []
            : List<Worker>.from(json["workers"].map((x) => Worker.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "site_name": siteName,
        "owner_name": ownerName,
        "owner_contact": ownerContact,
        "address": address,
        "image": image,
        "total_budget": totalBudget,
        "budget_left": budgetLeft,
        "is_completed": isCompleted,
        "start_time": startTime,
        "end_time": endTime,
        "lat": lat,
        "long": long,
        "radius": radius,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "supervisor_id": supervisorId,
        "total_workers": totalWorkers,
        "present_workers": presentWorkers,
        "total_transactions": totalTransactions,
        "site_payouts": List<dynamic>.from(sitePayouts.map((x) => x.toJson())),
        "worker_payouts":
            List<dynamic>.from(workerPayouts.map((x) => x.toJson())),
        "workers": List<dynamic>.from(workers.map((x) => x.toJson())),
      };
}

class Payout {
  int id;
  int amount;
  String purpose;
  int siteId;
  DateTime createdAt;
  String comment;
  int supervisorId;
  String siteImg;
  String siteName;
  int? workerId;
  dynamic workerImg;
  String? workerName;

  Payout({
    required this.id,
    required this.amount,
    required this.purpose,
    required this.siteId,
    required this.createdAt,
    required this.comment,
    required this.supervisorId,
    required this.siteImg,
    this.workerId,
    this.workerImg,
    this.workerName,
    required this.siteName,
  });

  factory Payout.fromJson(Map<String, dynamic> json) => Payout(
        id: json["id"] ?? 0,
        amount: json["amount"] ?? 0,
        purpose: json["purpose"] ?? "",
        siteId: json["site_id"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        comment: json["comment"] ?? "",
        supervisorId: json["supervisor_id"] ?? 0,
        siteImg: json["site_img"] ?? "",
        workerId: json["worker_id"] ?? 0,
        workerImg: json["worker_img"] ?? "",
        siteName: json["site_name"]??"",
        workerName: json["worker_name"]??"",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "purpose": purpose,
        "site_id": siteId,
        "created_at": createdAt.toIso8601String(),
        "comment": comment,
        "supervisor_id": supervisorId,
        "site_img": siteImg,
        "worker_id": workerId,
        "worker_img": workerImg,
      };
}

class Worker {
  int id;
  String fullname;
  DateTime createdAt;
  dynamic profileImg;

  Worker({
    required this.id,
    required this.fullname,
    required this.createdAt,
    required this.profileImg,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["id"] ?? 0,
        fullname: json["fullname"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        profileImg: json["profile_img"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "created_at": createdAt.toIso8601String(),
        "profile_img": profileImg,
      };
}
