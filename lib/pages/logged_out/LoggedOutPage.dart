import 'package:fantasy_football/blocs/admin_actions/admin_actions_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/dialogs/admin_actions_dialog.dart';
import 'package:fantasy_football/services/login_service.dart';
import 'package:fantasy_football/svg/login.svg.dart';
import 'package:fantasy_football/widgets/shared/icon_button_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

class LoggedOutPage extends StatelessWidget {
  const LoggedOutPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: C.transparent,
        elevation: 0,
        leading: IconButtonV2(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: C.dark_1,
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<AdminActionsCubit>(),
                  child: const AdminActionsDialog(),
                );
              }
            );
          },
          icon: Icons.admin_panel_settings_outlined,
          size: 30,
        )
      ),
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