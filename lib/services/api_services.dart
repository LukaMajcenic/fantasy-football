import 'dart:convert';
import 'dart:typed_data';

import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/pages/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import 'package:image/image.dart' as Img;
import 'package:image/image.dart';

class ApiServices
{
  static Future<List<Player>> getPlayers() async
  {
    List<Player> players = [];

    final response = await http.get(
      Uri.parse('https://v3.football.api-sports.io/players?league=39&season=2021&page=1'),
      headers: {
        'x-rapidapi-key': 'b5cc1f9b7a050c8ac85c2830cfd47baa',
      }
    );

    dynamic responseJson = jsonDecode(response.body);

    for(var response in responseJson['response'] as List<dynamic>)
    {
      var player = response['player'];
      var statistics = response['statistics'][0];
      
      players.add(Player(
        playerID: player['id'] as int,
        firstName: player['firstname'] as String,
        lastName: player['lastname'] as String,
        photo: await Player.bytes(player['photo'] as String),
        position: Position.generatePostition(statistics['games']['position'] as String)
      ));
    }

    return players;
  }
}