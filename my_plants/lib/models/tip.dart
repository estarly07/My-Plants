// To parse this JSON data, do
//
//     final tip = tipFromMap(jsonString);

import 'dart:convert';

Tip tipFromMap(String str, String id) => Tip.fromMap(json.decode(str), id);

String tipToMap(Tip data) => json.encode(data.toMap());

class Tip {
  Tip({
    required this.id,
    required this.picture,
    required this.tip,
    required this.url,
  });

  String picture;
  String tip;
  String id;
  String url;

  factory Tip.fromMap(Map<String, dynamic> json, String id) =>
      Tip(picture: json["picture"], tip: json["tip"], url: json["url"], id: id);

  Map<String, dynamic> toMap() =>
      {"picture": picture, "tip": tip, "url": url, "id": id};
}
