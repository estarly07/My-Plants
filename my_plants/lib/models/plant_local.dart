class Plant {
  int? idPlant;
  late String name;
  late String nameScientific;
  late int daySummer;
  late int dayWinter;
  late int days;
  late String typePlant;

  Plant({
    this.idPlant,
    required this.name,
    required this.nameScientific,
    required this.daySummer,
    required this.dayWinter,
    required this.days,
    required this.typePlant,
  });

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
      idPlant: json["idPlant"],
      name: json["name"],
      nameScientific: json["name_scientific"],
      daySummer: json["day_summer"],
      dayWinter: json["day_winter"],
      days: json["days"],
      typePlant: json["type_plant"]);

  Map<String, Object?> toJson() => {
        "idPlant": idPlant,
        "name": name,
        "name_scientific": nameScientific,
        "day_summer": daySummer,
        "day_winter": dayWinter,
        "days": days,
        "type_plant": typePlant,
      };
}
