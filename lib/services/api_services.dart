import 'dart:convert';

import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/pages/test.dart';

import 'package:http/http.dart' as http;

class ApiServices
{
  static Future<List<Player>> getPlayers() async
  {
    List<Player> players = [];

/*     final response = await http.get(
      Uri.parse('https://v3.football.api-sports.io/players?league=39&season=2021&page=1'),
      headers: {
        'x-rapidapi-key': 'b5cc1f9b7a050c8ac85c2830cfd47baa',
      }
    );

    dynamic responseJson = jsonDecode(response.body); */

    dynamic responseJson = jsonDecode(Test.json);

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

    print(players);
    return players;
  }

  static Future getPlayer(String playerId) async
  {
    final response = await http.get(
      Uri.parse('https://v3.football.api-sports.io/players?id=$playerId&season=2021'),
      headers: {
        'x-rapidapi-key': 'b5cc1f9b7a050c8ac85c2830cfd47baa',
      }
    );

    dynamic responseJson = jsonDecode(response.body);

    print(playerId);

    //print(responseJson);

    var player = responseJson['response'][0]['player'];
    var statistics = responseJson['response'][0]['statistics'][0];
      
    return Player(
      playerID: player['id'] as int,
      firstName: player['firstname'] as String,
      lastName: player['lastname'] as String,
      photo: await Player.bytes(player['photo'] as String),
      position: Position.generatePostition(statistics['games']['position'] as String)
    );
  }
}