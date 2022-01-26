class User {
  final String user;
  final String pass;
  final String age;
  final int? id;

  User({required this.user, required this.pass, required this.age, this.id});

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: json["user"],
        pass: json["pass"],
        age: json["age"],
        id: json["id"],
      );
  Map<String, Object?> toJson() => {
        "user": user,
        "pass": pass,
        "age": age,
        "id": id,
      };
}
