import 'package:bloc/bloc.dart';
import 'package:chat_app/models/users/create_user.dart';
import 'package:chat_app/modules/social_register/register_cubit/states.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatRegisterCubit extends Cubit<ChatRegisterCubitStates> {
  ChatRegisterCubit() : super(ChatRegisterInitialState());

  //search for the best answer for BlocProvider.of(context)
  static ChatRegisterCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;

  void changePasswordVisibilityState() {
    isPassword = !isPassword;
    // ignore: unnecessary_statements
    isPassword
        ? suffix = Icons.remove_red_eye_outlined
        : suffix = Icons.visibility_off;
    emit(ChatRegisterPasswordVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ChatRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      //print(value.additionalUserInfo.username);
      //  print(value.credential.providerId);
      print('done');
      userCreate(name: name,phone: phone,email: email,uId: value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      emit(ChatRegisterErrorState());
    });
  }

  void userCreate(
      {
        required String name,
        required String email,
        required String phone,
        required String uId,
      }
      ) {
    UserModel model=UserModel(name:name,email: email ,phone: phone,uId: uId,deviceToken: deviceToken);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap(model))
        .then((value){
          emit(ChatCreateUserSuccessState(uId));
    })
        .catchError((error){
          print(error.toString());
          emit(ChatCreateUserErrorState());
    });
  }
}
