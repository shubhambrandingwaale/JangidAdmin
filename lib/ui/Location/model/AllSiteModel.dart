// To parse this JSON data, do
//
//     final allsiteModel = allsiteModelFromJson(jsonString);

import 'dart:convert';

AllsiteModel allsiteModelFromJson(String str) =>
    AllsiteModel.fromJson(json.decode(str));

String allsiteModelToJson(AllsiteModel data) => json.encode(data.toJson());

class AllsiteModel {
  String message;
  int status;
  List<AllSiteDataList> data;

  AllsiteModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory AllsiteModel.fromJson(Map<String, dynamic> json) => AllsiteModel(
        message: json["message"] ?? "",
        status: json["status"] ?? 0,
        data: json["data"] == null
            ? []
            : List<AllSiteDataList>.from(
                json["data"].map((x) => AllSiteDataList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AllSiteDataList {
  int id;
  String siteName;
  String ownerName;
  String ownerContact;
  String address;
  String image;
  int totalBudget;
  int budgetLeft;
  String? supervisorId;
  bool isCompleted;
  String startTime;
  String endTime;
  String? lat;
  String? long;
  int? radius;
  DateTime createdAt;
  DateTime updatedAt;

  AllSiteDataList({
    required this.id,
    required this.siteName,
    required this.ownerName,
    required this.ownerContact,
    required this.address,
    required this.image,
    required this.totalBudget,
    required this.budgetLeft,
    required this.supervisorId,
    required this.isCompleted,
    required this.startTime,
    required this.endTime,
    required this.lat,
    required this.long,
    required this.radius,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllSiteDataList.fromJson(Map<String, dynamic> json) =>
      AllSiteDataList(
        id: json["id"] ?? 0,
        siteName: json["site_name"] ?? "",
        ownerName: json["owner_name"] ?? "",
        ownerContact: json["owner_contact"] ?? "",
        address: json["address"] ?? "",
        image: json["image"] ?? "",
        totalBudget: json["total_budget"] ?? 0,
        budgetLeft: json["budget_left"] ?? 0,
        supervisorId: json["supervisor_id"] ?? "",
        isCompleted: json["is_completed"] ?? false,
        startTime: json["start_time"] ?? "",
        endTime: json["end_time"] ?? "",
        lat: json["lat"] ?? "",
        long: json["long"] ?? "",
        radius: json["radius"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "supervisor_id": supervisorId,
        "is_completed": isCompleted,
        "start_time": startTime,
        "end_time": endTime,
        "lat": lat,
        "long": long,
        "radius": radius,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
