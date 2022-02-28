import 'dart:typed_data';

import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/position.dart';
import 'package:fantasy_football/models/squad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PlayerImageWidget extends StatelessWidget {
  const PlayerImageWidget({
    this.player, 
    this.playerId, 
    this.position,
    this.margin,
    Key? key }) : super(key: key);

  final Player? player;
  final String? playerId;
  final Position? position;
  final List<double>? margin;

  EdgeInsets getMargin()
  {
    if(margin?.length == 1)
    {
      return EdgeInsets.all(margin?[0] as double);
    }
    else if(margin?.length == 2)
    {
      return EdgeInsets.symmetric(
        vertical: margin?[0] as double, 
        horizontal: margin?[1] as double
      );
    }
    else if(margin?.length == 4)
    {
      return EdgeInsets.only(
        top: margin?[0] as double,
        right: margin?[1] as double,
        bottom: margin?[2] as double,
        left: margin?[3] as double
      );
    }
    else if(margin != null)
    {
      throw ("Margins array size can only be 1, 2 or 4");
    }

    return EdgeInsets.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getMargin(),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Text(
            position?.shortName ?? player?.position.shortName as String,
            style: TextStyle(
              color: position?.color ?? player?.position.color
            )
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  position?.color ?? player?.position.color.withOpacity(0.6) as Color,
                  Colors.transparent
                ]
              )
            ),
            child: FutureBuilder<Uint8List>(
              future: Player.getUint8List(playerId ?? (player?.playerID as int).toString()),
              builder: (_, snapshot) {

                if(snapshot.hasData)
                {
                  return Image.memory(snapshot.data as Uint8List);
                }

                return AspectRatio(
                    aspectRatio: 1/1,
                    child: SpinKitRipple(
                      color: C.white.withOpacity(0.4)
                    ),
                );
              },
            )
          ) 
        ]
      ),
    );
  }
}