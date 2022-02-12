import 'package:fantasy_football/services/login_service.dart';
import 'package:fantasy_football/svg/login.svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

class LoggedOutPage extends StatelessWidget {
  const LoggedOutPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SizedBox(
            height: 600,
            child: SvgPicture.string(LoginSvg.rawSvg, fit: BoxFit.fitHeight)
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("Login as guest"),
                  onPressed: () => LoginService.loginAsGuest(),
                ),
                ElevatedButton(
                  child: const Text("Login with google"),
                  onPressed: () => LoginService.signInWithGoogle(),
                ),
              ]
            )
          ),
        ]
      ),
    );
  }
}