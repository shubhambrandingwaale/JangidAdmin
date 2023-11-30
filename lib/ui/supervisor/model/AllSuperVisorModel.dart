// To parse this JSON data, do
//
//     final allSuperVisorModel = allSuperVisorModelFromJson(jsonString);

import 'dart:convert';

AllSuperVisorModel allSuperVisorModelFromJson(String str) =>
    AllSuperVisorModel.fromJson(json.decode(str));

String allSuperVisorModelToJson(AllSuperVisorModel data) =>
    json.encode(data.toJson());

class AllSuperVisorModel {
  String message;
  int status;
  List<SuperVisorDataList> data;

  AllSuperVisorModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory AllSuperVisorModel.fromJson(Map<String, dynamic> json) =>
      AllSuperVisorModel(
        message: json["message"] ?? "",
        status: json["status"] ?? 0,
        data: List<SuperVisorDataList>.from(
            json["data"].map((x) => SuperVisorDataList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SuperVisorDataList {
  int id;
  String fullname;
  String email;
  String phone;
  bool isDisabled;
  String role;
  String username;
  String password;
  String hpassword;
  bool isPresent;
  DateTime createdAt;
  DateTime updatedAt;
  String profileImg;
  int walletBalance;

  SuperVisorDataList({
    required this.id,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.isDisabled,
    required this.role,
    required this.username,
    required this.password,
    required this.hpassword,
    required this.isPresent,
    required this.createdAt,
    required this.updatedAt,
    required this.profileImg,
    required this.walletBalance
  });

  factory SuperVisorDataList.fromJson(Map<String, dynamic> json) =>
      SuperVisorDataList(
        id: json["id"] ?? 0,
        fullname: json["fullname"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        isDisabled: json["is_disabled"] ?? false,
        role: json["role"] ?? "",
        username: json["username"] ?? "",
        password: json["password"] ?? "",
        hpassword: json["hpassword"] ?? "",
        isPresent: json["is_present"] ?? false,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profileImg: json["profile_img"] ?? "",
        walletBalance: json["wallet_balance"]??0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "is_disabled": isDisabled,
        "role": role,
        "username": username,
        "password": password,
        "hpassword": hpassword,
        "is_present": isPresent,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "profile_img": profileImg,
      };
}
