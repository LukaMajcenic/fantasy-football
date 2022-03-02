import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiServices
{
  static Future<List<Player>> getPlayersFromAPI() async
  {
    List<Player> players = [];
    int page = 1;

    while (true)
    {
      // ignore: avoid_print
      print("page:" + page.toString());
      if(page % 10 == 0)
      {
        // ignore: avoid_print
        print("starting sleep");
        sleep(const Duration(seconds: 80));
        // ignore: avoid_print
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
            position: Position.generatePostition(statistics['games']['position'] as String),
            nationality: player['nationality'],
            teamId: (statistics['team']['id'] as int).toString(),
            dateOfBirth: DateTime.parse(player['birth']['date']),
            height: player['height'] == null ? null : int.parse((player['height'] as String).split(" ")[0]),
            weight: player['weight'] == null ? null : int.parse((player['weight'] as String).split(" ")[0]),
            injured: player['injured']
          ));
        }
      }
    }

    return players;
  }

  static Future getPlayerFromAPI() async
  {
    Response response = await http.get(
      Uri.parse("https://v3.football.api-sports.io/players?league=39&season=2021"),
      headers: {
        'x-rapidapi-key': 'b5cc1f9b7a050c8ac85c2830cfd47baa',
      }
    );
    dynamic responseJson = jsonDecode(response.body);

    var data = responseJson['response'][0];
    var player = data['player'];
    var statistics = data['statistics'][0];

    var playerTest = Player(
      playerID: player['id'] as int,
      firstName: player['firstname'] as String,
      lastName: player['lastname'] as String,
      position: Position.generatePostition(statistics['games']['position'] as String),
      nationality: player['nationality'],
      teamId: (statistics['team']['id'] as int).toString(),
      dateOfBirth: DateTime.parse(player['birth']['date']),
      height: player['height'] == null ? null : int.parse((player['height'] as String).split(" ")[0]),
      weight: player['weight'] == null ? null : int.parse((player['weight'] as String).split(" ")[0]),
      injured: player['injured']
    );
    inspect(playerTest.toJson());
  }
}