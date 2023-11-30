// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  List<Datum> data;

  ImageModel({
    required this.data,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<Map<String, dynamic>>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String item;
  String image;
  int id;

  Datum({
    required this.item,
    required this.image,
    required this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    item: json["item"]??"",
    image: json["image"]??"",
    id: json["id"]??0,
  );

  Map<String, dynamic> toJson() => {
    "item": item,
    "image": image,
    "id": id,
  };
}