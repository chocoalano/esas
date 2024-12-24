class CurrentShiftNowModel {
  int id;
  int groupAttendanceId;
  int userId;
  int timeAttendanceId;
  String date;
  String status;
  int timeId;
  String timeType;
  String timeIn;
  String timeOut;
  String timePattern;
  String groupName;
  String groupPattern;
  int userIdPrimary;
  String userName;
  String userNik;
  String userEmail;
  String userPhone;
  String userGender;

  CurrentShiftNowModel({
    required this.id,
    required this.groupAttendanceId,
    required this.userId,
    required this.timeAttendanceId,
    required this.date,
    required this.status,
    required this.timeId,
    required this.timeType,
    required this.timeIn,
    required this.timeOut,
    required this.timePattern,
    required this.groupName,
    required this.groupPattern,
    required this.userIdPrimary,
    required this.userName,
    required this.userNik,
    required this.userEmail,
    required this.userPhone,
    required this.userGender,
  });

  factory CurrentShiftNowModel.fromJson(Map<String, dynamic> json) {
    return CurrentShiftNowModel(
      id: json['id'],
      groupAttendanceId: json['groupAttendanceId'],
      userId: json['userId'],
      timeAttendanceId: json['timeAttendanceId'],
      date: json['date'],
      status: json['status'],
      timeId: json['timeId'],
      timeType: json['timeType'],
      timeIn: json['timeIn'],
      timeOut: json['timeOut'],
      timePattern: json['timePattern'],
      groupName: json['groupName'],
      groupPattern: json['groupPattern'],
      userIdPrimary: json['userIdprimary'],
      userName: json['userName'],
      userNik: json['userNik'],
      userEmail: json['userEmail'],
      userPhone: json['userPhone'],
      userGender: json['userGender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupAttendanceId': groupAttendanceId,
      'userId': userId,
      'timeAttendanceId': timeAttendanceId,
      'date': date,
      'status': status,
      'timeId': timeId,
      'timeType': timeType,
      'timeIn': timeIn,
      'timeOut': timeOut,
      'timePattern': timePattern,
      'groupName': groupName,
      'groupPattern': groupPattern,
      'userIdprimary': userIdPrimary,
      'userName': userName,
      'userNik': userNik,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'userGender': userGender,
    };
  }
}
