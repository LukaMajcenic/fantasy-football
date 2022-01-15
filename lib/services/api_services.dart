import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/player_image.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/pages/test.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiServices
{
  static Future<List<Player>> getPlayers() async
  {
    List<Player> players = [];
    int page = 1;

    while (true)
    {
      print("page:" + page.toString());
      if(page % 10 == 0)
      {
        print("starting sleep");
        sleep(const Duration(seconds: 80));
        print("ending sleep");
      }

      Response response = await http.get(
        Uri.parse("https://v3.football.api-sports.io/players?league=39&season=2021&page=${page++}"),
        headers: {
          'x-rapidapi-key': 'b5cc1f9b7a050c8ac85c2830cfd47baa',
        }
      );
      dynamic responseJson = jsonDecode(response.body);

      //Happens when page exceeds maximum
      if(responseJson['paging']['total'] < responseJson['paging']['current'])
      {
        break;
      }

      for(var data in responseJson['response'])
      {
        var player = data['player'];
        var statistics = data['statistics'][0];

        if(statistics['games']['appearences'] != null && statistics['games']['appearences'] > 15)
        {
          players.add(Player(
            playerID: player['id'] as int,
            firstName: player['firstname'] as String,
            lastName: player['lastname'] as String,
            image: PlayerImage(playerID: player['id'] as int, uint8list: Uint8List(1)),
            position: Position.generatePostition(statistics['games']['position'] as String)
          ));
        }
      }
    }

    return players;
  }
}