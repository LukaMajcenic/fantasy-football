import 'package:firebase_auth/firebase_auth.dart';

class LoginService
{
  static Future<void> loginAsGuest() async 
  {
    await FirebaseAuth.instance.signInAnonymously();
  }
}