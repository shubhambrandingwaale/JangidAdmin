// To parse this JSON data, do
//
//     final expenseModel = expenseModelFromJson(jsonString);

import 'dart:convert';

List<ExpenseModel> expenseModelFromJson(String str) => List<ExpenseModel>.from(json.decode(str).map((x) => ExpenseModel.fromJson(x)));

String expenseModelToJson(List<ExpenseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseModel {
  int id;
  int amount;
  String purpose;
  int siteId;
  dynamic workerId;
  DateTime createdAt;
  String siteName;
  dynamic workerName;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.purpose,
    required this.siteId,
    required this.workerId,
    required this.createdAt,
    required this.siteName,
    required this.workerName,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    id: json["id"]??0,
    amount: json["amount"]??0,
    purpose: json["purpose"]??"",
    siteId: json["site_id"]??0,
    workerId: json["worker_id"],
    createdAt: DateTime.parse(json["created_at"]),
    siteName: json["site_name"]??"",
    workerName: json["worker_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "purpose": purpose,
    "site_id": siteId,
    "worker_id": workerId,
    "created_at": createdAt.toIso8601String(),
    "site_name": siteName,
    "worker_name": workerName,
  };
}
