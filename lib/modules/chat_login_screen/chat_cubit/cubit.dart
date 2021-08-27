import 'package:bloc/bloc.dart';
import 'package:chat_app/models/users/create_user.dart';
import 'package:chat_app/modules/chat_login_screen/chat_cubit/states.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginCubit extends Cubit<ChatLoginCubitStates> {
  LoginCubit() : super(ChatInitialStates());

  //search for the best answer for BlocProvider.of(context)
  static LoginCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;

  void changePasswordVisibilityState() {
    isPassword = !isPassword;
    // ignore: unnecessary_statements
    isPassword
        ? suffix = Icons.remove_red_eye_outlined
        : suffix = Icons.visibility_off;
    emit(ChatPasswordVisibilityState());
  }

  void userLogin({required String email, required String password}) {
    emit(ChatLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(ChatLoginSuccessState(value.user!.uid));
      //print(value.credential.token);
      print('loginDone');
    }).catchError((error) {
      print(error.toString());
      emit(ChatLoginErrorState());
    });
  }


  void googleLogin() async {
    emit(GoogleLoginLoadingState());
    final user = await googleSignIn.signIn();
    if (user == null) {
      print('user is not found');
      return;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        userCreate(
          name: value.user!.displayName,
          uId: value.user!.uid,
          email: value.user!.email,
          phone: value.user!.phoneNumber,
          image: value.user!.photoURL,
          cover: value.user!.photoURL,
        );

      }).catchError((error) {
        print(error.toString());
        emit(GoogleLoginErrorState());
      });
    }
  }
  void googleLogout()async{
    await googleSignIn.disconnect();
     firebaseUnAuth();
  }
  void firebaseUnAuth(){
    FirebaseAuth.instance.signOut();

  }

  void userCreate({
    required String? name,
    required String? email,
    required String? phone,
    required String? uId,
    String? image,
    String? cover,
    String? bio,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone ?? '',
        uId: uId,
        image: image,
        cover: cover,
        bio: bio ?? '',
        deviceToken: deviceToken);
    if (FirebaseFirestore.instance.collection('users').doc(uId).id == uId) {
      print('user is already found');
      emit(CreateUserSuccessState(uId));
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(model.toMap(model))
          .then((value) {
        emit(CreateUserSuccessState(uId));
      }).catchError((error) {
        print(error.toString());
        emit(CreateGoogleUserErrorState());
      });
    }
  }

}
