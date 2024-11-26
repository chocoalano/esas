// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

import '../user_model.dart';

List<NotificationListModel> notificationListModelFromJson(String str) =>
    List<NotificationListModel>.from(
        json.decode(str).map((x) => NotificationListModel.fromJson(x)));

String notificationListModelToJson(List<NotificationListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationListModel {
  int id;
  int from;
  int to;
  String isread;
  String type;
  String title;
  String message;
  String payload;
  UserModel? fromUser;
  UserModel? toUser;

  NotificationListModel({
    required this.id,
    required this.from,
    required this.to,
    required this.isread,
    required this.type,
    required this.title,
    required this.message,
    required this.payload,
    required this.fromUser,
    required this.toUser,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) =>
      NotificationListModel(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        isread: json["isread"],
        type: json["type"],
        title: json["title"],
        message: json["message"],
        payload: json["payload"],
        fromUser: json["fromUser"] != null
            ? UserModel.fromJson(json["fromUser"])
            : null,
        toUser:
            json["toUser"] != null ? UserModel.fromJson(json["toUser"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "isread": isread,
        "type": type,
        "title": title,
        "message": message,
        "payload": payload,
        "fromUser": fromUser?.toJson(),
        "toUser": toUser?.toJson(),
      };
}
