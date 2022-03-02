import 'package:fantasy_football/blocs/admin_actions/admin_actions_cubit.dart';
import 'package:fantasy_football/const/colors.dart';
import 'package:fantasy_football/dialogs/admin_actions_dialog.dart';
import 'package:fantasy_football/services/login_service.dart';
import 'package:fantasy_football/svg/login.svg.dart';
import 'package:fantasy_football/widgets/shared/icon_button_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            child: SvgPicture.string(LoginSvg.raw, fit: BoxFit.fitHeight)
          ),
          Center(
            child: SizedBox(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text("Login as guest"),
                        Icon(Icons.person_off_outlined)
                      ],
                    ),
                    onPressed: () => LoginService.loginAsGuest(),
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Login with google"),
                        Image.network(
                          "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png",
                          height: 30,
                        )
                      ],
                    ),
                    onPressed: () => LoginService.signInWithGoogle(),
                  ),
                ]
              ),
            )
          ),
        ]
      ),
    );
  }
}