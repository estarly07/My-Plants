import 'dart:convert';

TypePlant TypePlantFromMap(String str, String id) =>
    TypePlant.fromMap(json.decode(str), id);

class TypePlant {
  TypePlant({
    required this.id,
    required this.name,
    required this.nameScientific,
    required this.picture,
    required this.description,
    required this.maintenance,
  });

  String id;
  String name;
  String nameScientific;
  String picture;
  String description;
  Maintenance maintenance;

  factory TypePlant.fromMap(Map<String, dynamic> json, String id) => TypePlant(
        id: id,
        name: json["name"],
        nameScientific: json["name scientific"],
        picture: json["picture"],
        description: json["description"],
        maintenance: Maintenance.fromMap(json["maintenance"]),
      );
}

class Maintenance {
  Maintenance({
    required this.minimumTemperature,
    required this.idealTemperature,
    required this.sunlight,
    required this.daySummer,
    required this.dayWinter,
    required this.irrigation,
  });

  String minimumTemperature;
  String idealTemperature;
  String sunlight;
  int daySummer;
  int dayWinter;
  String irrigation;

  factory Maintenance.fromMap(Map<String, dynamic> json) => Maintenance(
        minimumTemperature: json["minimum temperature"],
        idealTemperature: json["ideal temperature"],
        sunlight: json["sunlight"],
        irrigation: json["irrigation"],
        daySummer: json["day summer"],
        dayWinter: json["day winter"],
      );
}
