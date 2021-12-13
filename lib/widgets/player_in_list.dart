import 'package:fantasy_football/main.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/pages/player_page.dart';
import 'package:flutter/material.dart';

class PlayerInList extends StatelessWidget {
  const PlayerInList(this.player, this.sub, { Key? key }) : super(key: key);

  final Player player;
  final bool sub;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[900],
        elevation: 0
      ),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => PlayerDetails())
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [  
                Container(
                  color: !sub ? player.position.color : Colors.grey[850],
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    player.position.shortName,
                    style: TextStyle(color: sub ? player.position.color : Colors.grey[900]),
                  ),
                ),
                Image.network(player.photo, height: 70)
              ],
            )
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Row(
                  children: [Text(player.fullname())]
                ),
                Row(children: player.ratingsWidget())
              ]
            )
          )
        ],
      )
    );
  }
}