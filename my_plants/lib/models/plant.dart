import 'dart:convert';

Plant plantFromMap(String str, String id) =>
    Plant.fromMap(json.decode(str), id);

class Plant {
  Plant({
    required this.id,
    required this.name,
    required this.picture,
    required this.description,
    required this.maintenance,
  });

  String id;
  String name;
  String picture;
  String description;
  Maintenance maintenance;

  factory Plant.fromMap(Map<String, dynamic> json, String id) => Plant(
        id: id,
        name: json["name"],
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
    required this.irrigation,
  });

  String minimumTemperature;
  String idealTemperature;
  String sunlight;
  String irrigation;

  factory Maintenance.fromMap(Map<String, dynamic> json) => Maintenance(
        minimumTemperature: json["minimum temperature"],
        idealTemperature: json["ideal temperature"],
        sunlight: json["sunlight"],
        irrigation: json["irrigation"],
      );
}
