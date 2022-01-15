import 'dart:math';
import 'dart:typed_data';

import 'package:fantasy_football/models/player_image.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/rating.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:image/image.dart' as Img;

class Player {
  int playerID;
  String firstName;
  String lastName;
  PlayerImage image;
  Position position = Position.attacker();
  List<Rating> ratings = [];

  Player({required this.playerID, 
  required this.firstName, 
  required this.lastName,
  required this.image,
  required this.position})
  {
    var rng = Random();
    for(int i = 0; i < 12; i++)
    {
      ratings.add(Rating(rng.nextDouble() * (10 - 1) + 1, "R" + (i+1).toString()));
    }
  }

  String fullname() => firstName + " " + lastName;

  static Future<PlayerImage> getUint8List(int PlayerID) async
  {
    String url = "https://media.api-sports.io/football/players/$PlayerID.png";
    ByteData byteData = await NetworkAssetBundle(Uri.parse(url)).load(url);

    Img.Image image = Img.decodeImage(byteData.buffer.asUint8List()) as Img.Image;

    return PlayerImage(playerID: PlayerID, uint8list: Img.encodePng(image) as Uint8List);
  }

  static Future<Uint8List> bytes(String strURL) async 
  {
    //strURL = "https://media.api-sports.io/football/players/276.png";
    ByteData byteData = await NetworkAssetBundle(Uri.parse(strURL)).load("https://i.picsum.photos/id/840/200/200.jpg?hmac=-YJWWvNEnqyfLU6PEcCnd42hVvQ9PthuYuG_M3LOZo0");

    //ByteData byteData = await rootBundle.load('lib/161.png');

    //print(byteData.buffer.asUint8List());

    Img.Image image = Img.decodeImage(byteData.buffer.asUint8List()) as Img.Image;

/*     image.channels = Img.Channels.rgba;
    var pixels = image.getBytes();
    for (int i = 0, len = pixels.length; i < len; i += 4) 
    {
      if (pixels[i] > 225 && pixels[i + 1] > 225 && pixels[i + 2] > 225) 
      {
        pixels[i + 3] = 0;
      }
    } */

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

  static Player fromJson(int playerID, dynamic player, Uint8List image)
  {
    return Player(
      playerID: playerID,
      firstName: player['firstName'],
      lastName: player['lastName'],
      position: Position.generatePostition(player['position']),
      image: PlayerImage(playerID: playerID, uint8list: image)
    );
  }
}