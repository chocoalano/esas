class UserModel {
  int id;
  String name;
  String nik;
  String email;
  String password;
  String phone;
  String placebirth;
  DateTime datebirth;
  String gender;
  String blood;
  String maritalStatus;
  String religion;
  String? image;

  UserModel({
    required this.id,
    required this.name,
    required this.nik,
    required this.email,
    required this.password,
    required this.phone,
    required this.placebirth,
    required this.datebirth,
    required this.gender,
    required this.blood,
    required this.maritalStatus,
    required this.religion,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        placebirth: json["placebirth"],
        datebirth: DateTime.parse(json["datebirth"]),
        gender: json["gender"],
        blood: json["blood"],
        maritalStatus: json["maritalStatus"],
        religion: json["religion"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "email": email,
        "password": password,
        "phone": phone,
        "placebirth": placebirth,
        "datebirth":
            "${datebirth.year.toString().padLeft(4, '0')}-${datebirth.month.toString().padLeft(2, '0')}-${datebirth.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "blood": blood,
        "maritalStatus": maritalStatus,
        "religion": religion,
        "image": image,
      };
}
