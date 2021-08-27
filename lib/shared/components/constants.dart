import 'package:chat_app/modules/chat_login_screen/chat_login_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/network/local/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();

void signOut(context) {
  CacheHelper.removeToken(key: 'uId').then((value) {
    if (value) {
      navigateAndFinish(context, ChatLoginScreen());
    }
    googleSignIn.isSignedIn().then((value) {
      if (value) googleSignIn.disconnect();
    }).catchError((error) {
      print(error.toString());
    });

  });
  FirebaseAuth.instance.signOut();
}

String deviceToken = '';
late String uId = '';
String googleUId = '';
bool hasUserModel=false;

//String lastMessage = '';
