import 'dart:ui';

import 'package:fantasy_football/blocs/squad_cubit.dart';
import 'package:fantasy_football/services/login_service.dart';
import 'package:fantasy_football/svg/login.svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            height: 600,
            child: SvgPicture.string(LoginSvg.rawSvg, fit: BoxFit.fitHeight)
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("Login as guest"),
                  onPressed: () => LoginService.loginAsGuest(context.read<SquadCubit>().state),
                ),
                ElevatedButton(
                  child: const Text("Login with google"),
                  onPressed: () => LoginService.signInWithGoogle(context.read<SquadCubit>().state),
                ),
              ]
            )
          ),
        ]
      ),
    );
  }
}