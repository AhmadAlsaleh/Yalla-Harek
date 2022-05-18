import 'dart:convert';

class GameModel {
  GameModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.dateTime,
    required this.maxPlayers,
    required this.address,
  });

  String id;
  String title;
  String description;
  String image;
  DateTime dateTime;
  int maxPlayers;
  String address;

  String get dateTimeToString => dateTime.toLocal().toString().split('.').first;

  factory GameModel.fromJson(String id, Map<String, dynamic> json) => GameModel(
        id: id,
        title: json["title"],
        description: json["description"],
        image: json["image"],
        dateTime: DateTime.parse("${json["dateTime"]}"),
        maxPlayers: json["maxPlayers"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "dateTime": dateTime.toString(),
        "maxPlayers": maxPlayers,
        "address": address,
      };
}
