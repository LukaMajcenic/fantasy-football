import 'package:fantasy_football/models/squad.dart';
import 'package:fantasy_football/services/db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService
{
  static Future<void> loginAsGuest(Squad squad) async 
  {
    await FirebaseAuth.instance.signInAnonymously();
  }

  static Future<void> signInWithGoogle(Squad squad) async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}