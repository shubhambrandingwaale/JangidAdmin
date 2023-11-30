// To parse required this JSON data, do
//
//     final supervisorModel = supervisorModelFromJson(jsonString);

import 'dart:convert';

SupervisorModel supervisorModelFromJson(String str) => SupervisorModel.fromJson(json.decode(str));

String supervisorModelToJson(SupervisorModel data) => json.encode(data.toJson());

class SupervisorModel {
  String message;
  int status;
  List<SupervisorListData> data;

  SupervisorModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory SupervisorModel.fromJson(Map<String, dynamic> json) => SupervisorModel(
    message: json["message"]??"",
    status: json["status"]??0,
    data: List<SupervisorListData>.from(json["data"].map((x) => SupervisorListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SupervisorListData {
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

  SupervisorListData({
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
  });

  factory SupervisorListData.fromJson(Map<String, dynamic> json) => SupervisorListData(
    id: json["id"]??0,
    fullname: json["fullname"]??"",
    email: json["email"]??"",
    phone: json["phone"]??"",
    isDisabled: json["is_disabled"]??false,
    role: json["role"]??"",
    username: json["username"]??"",
    password: json["password"]??"",
    hpassword: json["hpassword"]??"",
    isPresent: json["is_present"]??false,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    profileImg: json["profile_img"]??"",
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
