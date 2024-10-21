class NotificationModel {
  int id;
  int from;
  int to;
  String isRead;
  String type;
  String title;
  String? message;
  dynamic payload;
  UserModel fromUser;
  UserModel toUser;

  NotificationModel({
    required this.id,
    required this.from,
    required this.to,
    required this.isRead,
    required this.type,
    required this.title,
    this.message,
    this.payload,
    required this.fromUser,
    required this.toUser,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      isRead: json['isread'],
      type: json['type'],
      title: json['title'],
      message: json['message'],
      payload: json['payload'], // dynamic karena tipe payload bervariasi
      fromUser: UserModel.fromJson(json['fromUser']),
      toUser: UserModel.fromJson(json['toUser']),
    );
  }
}

class UserModel {
  int id;
  String name;
  String nik;
  String email;
  String phone;
  String placeOfBirth;
  String dateOfBirth;
  String gender;
  String blood;
  String maritalStatus;
  String religion;
  String image;

  UserModel({
    required this.id,
    required this.name,
    required this.nik,
    required this.email,
    required this.phone,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.gender,
    required this.blood,
    required this.maritalStatus,
    required this.religion,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      nik: json['nik'],
      email: json['email'],
      phone: json['phone'],
      placeOfBirth: json['placebirth'],
      dateOfBirth: json['datebirth'],
      gender: json['gender'],
      blood: json['blood'],
      maritalStatus: json['maritalStatus'],
      religion: json['religion'],
      image: json['image'],
    );
  }
}
