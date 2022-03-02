import 'package:fantasy_football/blocs/rounds/rounds_cubit.dart';
import 'package:fantasy_football/blocs/rounds/rounds_cubit_state.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/models/player.dart';
import 'package:fantasy_football/models/round.dart';
import 'package:fantasy_football/svg/field.svg.dart';
import 'package:fantasy_football/widgets/shared/loading.dart';
import 'package:fantasy_football/widgets/shared/player_rating_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class RoundDetailsPage extends StatelessWidget {
  RoundDetailsPage({required this.round, Key? key }) : super(key: key);

  final Round round;

  final Matrix4 perspective = Matrix4(
      1.0, 0.0, 0.0, 0.0, //
      0.0, 1.0, 0.0, 0.0, //
      0.0, 0.0, 1.0, 1 * 0.001, //
      0.0, 0.0, 0.0, 1.0,
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: C.dark_2,
            title: Text("${round.longName} details")
          ),
          body: Center(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Transform(
                    transform: perspective.scaled(1.0, 1.0, 1.0)
                    ..rotateX(math.pi - 210 * math.pi / 180)
                    ..rotateY(0.0)
                    ..rotateZ(0.0),
                    alignment: FractionalOffset.center,
                    child: SvgPicture.string(FieldSvg.raw)
                  ),
                ),
                Center(
                  child: BlocBuilder<RoundsCubit, RoundsCubitState>(
                    builder: (_, state) {
                      if(state.runtimeType == LoadingRoundInfo) {
                        return const Loading(text: "Loading round details",);
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PlayerRatingInfo(
                            player: state.rounds.firstWhere((r) => r.roundId == round.roundId).squadThatRoundDetails?.goalkeeper as Player,
                            round: round,
                          ),
                          PlayerRatingInfo(
                            player: state.rounds.firstWhere((r) => r.roundId == round.roundId).squadThatRoundDetails?.defender as Player,
                            round: round,
                          ),
                          PlayerRatingInfo(
                            player: state.rounds.firstWhere((r) => r.roundId == round.roundId).squadThatRoundDetails?.midfielder as Player,
                            round: round,
                          ),
                          PlayerRatingInfo(
                            player: state.rounds.firstWhere((r) => r.roundId == round.roundId).squadThatRoundDetails?.attacker as Player,
                            round: round,
                          ),
                        ],
                      );
                    }
                  ),
                )
              ],
            )
          ),
        ),
      );
  }
}