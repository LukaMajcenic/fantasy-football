import 'dart:math';
import 'dart:typed_data';

import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/rating.dart';
import 'package:fantasy_football/models/round.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:image/image.dart' as Img;

class Player {
  int playerID;
  String firstName;
  String lastName;
  Position position;
  List<Rating> ratings = [];

  Player({required this.playerID, 
  required this.firstName, 
  required this.lastName,
  required this.position});

  String fullname() => firstName + " " + lastName;

  static Future<Uint8List> getUint8List(String playerID) async
  {
    String url = "https://media.api-sports.io/football/players/$playerID.png";
    ByteData byteData = await NetworkAssetBundle(Uri.parse(url)).load(url);

    Img.Image image = Img.decodeImage(byteData.buffer.asUint8List()) as Img.Image;

    image.channels = Img.Channels.rgba;
    var pixels = image.getBytes();
    for (int i = 0, len = pixels.length; i < len; i += 4) 
    {
      if (pixels[i] > 225 && pixels[i + 1] > 225 && pixels[i + 2] > 225) 
      {
        pixels[i + 3] = 0;
      }
    }

    await Future.delayed(Duration(seconds: 6));
    return Img.encodePng(image) as Uint8List;
  }

  Map<String, Object> toJson()
  {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "position": position.fullName
    };
  }

  static Player fromJson(int playerID, dynamic player)
  {
    return Player(
      playerID: playerID,
      firstName: player['firstName'],
      lastName: player['lastName'],
      position: Position.generatePostition(player['position'])
    );
  }

  Rating getRoundRating(Round round)
  {
    return ratings.firstWhere((r) => r.roundId == round.roundId);
  }
}