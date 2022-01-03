import 'dart:math';
import 'dart:typed_data';

import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/rating.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:flutter/services.dart';

import 'package:image/image.dart' as Img;

class Player {
  int playerID;
  String firstName;
  String lastName;
  Uint8List photo;
  Position position = Position.attacker();
  SquadRole? squadRole;
  List<Rating> ratings = [];

  Player({required this.playerID, 
  required this.firstName, 
  required this.lastName,
  required this.photo,
  required this.position})
  {
    var rng = Random();
    for(int i = 0; i < 12; i++)
    {
      ratings.add(Rating(rng.nextDouble() * (10 - 1) + 1, "R" + (i+1).toString()));
    }
  }

  String fullname() => firstName + " " + lastName; 
  bool inFirstTeam() => squadRole == SquadRole.sub1 || squadRole == SquadRole.sub2;

  static Future<Uint8List> bytes(String strURL) async 
  {
    //strURL = "https://media.api-sports.io/football/players/276.png";
    ByteData byteData = (await NetworkAssetBundle(Uri.parse(strURL)).load(strURL));

    //ByteData byteData = await rootBundle.load('lib/161.png');

    //print(byteData.buffer.asUint8List());

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

    return Img.encodePng(image) as Uint8List;
  }
}