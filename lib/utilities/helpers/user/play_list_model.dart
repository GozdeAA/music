// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PlayList welcomeFromJson(String str) => PlayList.fromJson(json.decode(str));

String welcomeToJson(PlayList data) => json.encode(data.toJson());

class PlayList {
  final String? id;
  final String? title;
  final String? description;
  final int? duration;
  final bool? public;
  final bool? isLovedTrack;
  final bool? collaborative;
  final int? nbTracks;
  final int? fans;
  final String? link;
  final String? share;
  final String? picture;
  final String? pictureSmall;
  final String? pictureMedium;
  final String? pictureBig;
  final String? pictureXl;
  final String? checksum;
  final String? tracklist;
  final DateTime? creationDate;
  final String? md5Image;
  final String? pictureType;
  final Creator? creator;
  final String? type;
  final Tracks? tracks;

  PlayList({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.public,
    this.isLovedTrack,
    this.collaborative,
    this.nbTracks,
    this.fans,
    this.link,
    this.share,
    this.picture,
    this.pictureSmall,
    this.pictureMedium,
    this.pictureBig,
    this.pictureXl,
    this.checksum,
    this.tracklist,
    this.creationDate,
    this.md5Image,
    this.pictureType,
    this.creator,
    this.type,
    this.tracks,
  });

  factory PlayList.fromJson(Map<String, dynamic> json) => PlayList(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        duration: json["duration"],
        public: json["public"],
        isLovedTrack: json["is_loved_track"],
        collaborative: json["collaborative"],
        nbTracks: json["nb_tracks"],
        fans: json["fans"],
        link: json["link"],
        share: json["share"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        checksum: json["checksum"],
        tracklist: json["tracklist"],
        creationDate: json["creation_date"] == null
            ? null
            : DateTime.parse(json["creation_date"]),
        md5Image: json["md5_image"],
        pictureType: json["picture_type"],
        creator:
            json["creator"] == null ? null : Creator.fromJson(json["creator"]),
        type: json["type"],
        tracks: json["tracks"] == null ? null : Tracks.fromJson(json["tracks"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "duration": duration,
        "public": public,
        "is_loved_track": isLovedTrack,
        "collaborative": collaborative,
        "nb_tracks": nbTracks,
        "fans": fans,
        "link": link,
        "share": share,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "checksum": checksum,
        "tracklist": tracklist,
        "creation_date": creationDate?.toIso8601String(),
        "md5_image": md5Image,
        "picture_type": pictureType,
        "creator": creator?.toJson(),
        "type": type,
        "tracks": tracks?.toJson(),
      };
}

class Creator {
  final String? id;
  final String? name;
  final String? tracklist;
  final String? type;
  final String? link;

  Creator({
    this.id,
    this.name,
    this.tracklist,
    this.type,
    this.link,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        id: json["id"],
        name: json["name"],
        tracklist: json["tracklist"],
        type: json["type"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tracklist": tracklist,
        "type": type,
        "link": link,
      };
}

class Tracks {
  final List<Datum>? data;

  Tracks({
    this.data,
  });

  factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String? id;
  final bool? readable;
  final String? title;
  final String? titleShort;
  final String? titleVersion;
  final String? link;
  final String? duration;
  final String? rank;
  final bool? explicitLyrics;
  final int? explicitContentLyrics;
  final int? explicitContentCover;
  final String? preview;
  final String? md5Image;
  final int? timeAdd;
  final Creator? artist;
  final Album? album;
  final String? type;

  Datum({
    this.id,
    this.readable,
    this.title,
    this.titleShort,
    this.titleVersion,
    this.link,
    this.duration,
    this.rank,
    this.explicitLyrics,
    this.explicitContentLyrics,
    this.explicitContentCover,
    this.preview,
    this.md5Image,
    this.timeAdd,
    this.artist,
    this.album,
    this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        readable: json["readable"],
        title: json["title"],
        titleShort: json["title_short"],
        titleVersion: json["title_version"],
        link: json["link"],
        duration: json["duration"],
        rank: json["rank"],
        explicitLyrics: json["explicit_lyrics"],
        explicitContentLyrics: json["explicit_content_lyrics"],
        explicitContentCover: json["explicit_content_cover"],
        preview: json["preview"],
        md5Image: json["md5_image"],
        timeAdd: json["time_add"],
        artist:
            json["artist"] == null ? null : Creator.fromJson(json["artist"]),
        album: json["album"] == null ? null : Album.fromJson(json["album"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "readable": readable,
        "title": title,
        "title_short": titleShort,
        "title_version": titleVersion,
        "link": link,
        "duration": duration,
        "rank": rank,
        "explicit_lyrics": explicitLyrics,
        "explicit_content_lyrics": explicitContentLyrics,
        "explicit_content_cover": explicitContentCover,
        "preview": preview,
        "md5_image": md5Image,
        "time_add": timeAdd,
        "artist": artist?.toJson(),
        "album": album?.toJson(),
        "type": type,
      };
}

class Album {
  final String? id;
  final String? title;
  final String? cover;
  final String? coverSmall;
  final String? coverMedium;
  final String? coverBig;
  final String? coverXl;
  final String? md5Image;
  final String? tracklist;
  final String? type;

  Album({
    this.id,
    this.title,
    this.cover,
    this.coverSmall,
    this.coverMedium,
    this.coverBig,
    this.coverXl,
    this.md5Image,
    this.tracklist,
    this.type,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json["id"],
        title: json["title"],
        cover: json["cover"],
        coverSmall: json["cover_small"],
        coverMedium: json["cover_medium"],
        coverBig: json["cover_big"],
        coverXl: json["cover_xl"],
        md5Image: json["md5_image"],
        tracklist: json["tracklist"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "cover": cover,
        "cover_small": coverSmall,
        "cover_medium": coverMedium,
        "cover_big": coverBig,
        "cover_xl": coverXl,
        "md5_image": md5Image,
        "tracklist": tracklist,
        "type": type,
      };
}
