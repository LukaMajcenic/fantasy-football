import 'dart:typed_data';

import 'package:age_calculator/age_calculator.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/rating.dart';
import 'package:fantasy_football/models/round.dart';
import 'package:flutter/services.dart';

import 'package:image/image.dart' as img;

class Player {
  int playerID;
  String firstName;
  String lastName;
  Position position;
  String teamId;
  DateTime dateOfBirth;
  String nationality;
  int? height;
  int? weight;
  bool injured;
  List<Rating> ratings = [];

  Player({required this.playerID, 
  required this.firstName, 
  required this.lastName,
  required this.position,
  required this.teamId,
  required this.dateOfBirth,
  required this.nationality,
  required this.height,
  required this.weight,
  required this.injured});

  String get fullname => firstName + " " + lastName;
  String get countryFlag => "https://countryflagsapi.com/png/$nationality";
  String get clubLogo => "https://media.api-sports.io/football/teams/$teamId.png";
  String get heightText => "$height cm";
  String get weightText => "$weight kg";
  String get dateOfBirthText => "${dateOfBirth.day}.${dateOfBirth.month}.${dateOfBirth.year}";
  String get age => AgeCalculator.age(dateOfBirth).years.toString();

  static Future<Uint8List> getUint8List(String playerID) async
  {
    String url = "https://media.api-sports.io/football/players/$playerID.png";
    ByteData byteData = await NetworkAssetBundle(Uri.parse(url)).load(url);

    img.Image image = img.decodeImage(byteData.buffer.asUint8List()) as img.Image;

    image.channels = img.Channels.rgba;
    var pixels = image.getBytes();
    for (int i = 0, len = pixels.length; i < len; i += 4) 
    {
      if (pixels[i] > 225 && pixels[i + 1] > 225 && pixels[i + 2] > 225) 
      {
        pixels[i + 3] = 0;
      }
    }

    return img.encodePng(image) as Uint8List;
  }

  Map<String, Object> toJson()
  { 
    var json = {
      "firstName": firstName,
      "lastName": lastName,
      "position": position.fullName,
      "dateOfBirth": dateOfBirth.toString(),
      "injured": injured,
      "nationality": nationality,
      "teamId": teamId
    };

    if(height != null) {
      json["height"] = height as Object;
    }

    if(weight != null) {
      json["weight"] = weight as Object;
    }

    return json;
  }

  static Player fromJson(int playerID, dynamic player)
  {
    return Player(
      playerID: playerID,
      firstName: player['firstName'],
      lastName: player['lastName'],
      position: Position.generatePostition(player['position']),
      dateOfBirth: DateTime.parse(player['dateOfBirth']),
      height: player['height'] == null ? null : player['height'] as int,
      weight: player['weight'] == null ? null : player['weight'] as int,
      injured: player['injured'],
      nationality: player['nationality'],
      teamId: player['teamId']
    );
  }

  Rating getRoundRating(Round round)
  {
    return ratings.firstWhere((r) => r.roundId == round.roundId, orElse: () => Rating(rating: 0, roundId: ""));
  }
}