// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String? id;
  final String? name;
  final String? link;
  final String? picture;
  final String? pictureSmall;
  final String? pictureMedium;
  final String? pictureBig;
  final String? pictureXl;
  final String? country;
  final String? tracklist;
  final String? type;
  final List<String>? playListNames;

  User({
    this.id,
    this.name,
    this.link,
    this.picture,
    this.pictureSmall,
    this.pictureMedium,
    this.pictureBig,
    this.pictureXl,
    this.country,
    this.tracklist,
    this.type,
    this.playListNames,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    link: json["link"],
    picture: json["picture"],
    pictureSmall: json["picture_small"],
    pictureMedium: json["picture_medium"],
    pictureBig: json["picture_big"],
    pictureXl: json["picture_xl"],
    country: json["country"],
    tracklist: json["tracklist"],
    type: json["type"],
    playListNames: json["play_list_names"] == null ? [] : List<String>.from(json["play_list_names"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "link": link,
    "picture": picture,
    "picture_small": pictureSmall,
    "picture_medium": pictureMedium,
    "picture_big": pictureBig,
    "picture_xl": pictureXl,
    "country": country,
    "tracklist": tracklist,
    "type": type,
    "play_list_names": playListNames == null ? [] : List<dynamic>.from(playListNames!.map((x) => x)),
  };
}
