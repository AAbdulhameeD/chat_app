import 'package:bloc/bloc.dart';
import 'package:chat_app/layout/home_cubit/home_cubit.dart';
import 'package:chat_app/layout/home_cubit/home_states.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:chat_app/shared/network/local/bloc_observer.dart';
import 'package:chat_app/shared/network/local/dio_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/home_layout.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'modules/chat_login_screen/chat_login_screen.dart';
Widget? widget;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  deviceToken = (await FirebaseMessaging.instance.getToken())!;
  print('$deviceToken device token');
  await CacheHelper.init();

 uId = CacheHelper.getData(key: 'uId')??'';

  if (uId != '') {
    widget = ChatHomeLayout();
  } else {
    widget = ChatLoginScreen();
  }
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget? widget;

  const MyApp(this.widget) ;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HomeCubit()..getUserData()..getAllUsers(),

      child: BlocConsumer<HomeCubit,HomeLayoutStates>(
        listener: (context,states){},
        builder: (context,states){
          return MaterialApp(
            title: 'Chat App',
            theme: ThemeData(

            ),
            home: widget,
          );
        },
      ),
    );
  }
}


