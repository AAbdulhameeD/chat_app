import 'package:chat_app/layout/home_cubit/home_cubit.dart';
import 'package:chat_app/layout/home_cubit/home_states.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatHomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:HomeCubit.get(context).currentIndex ,
            onTap: (index){
              HomeCubit.get(context).changeNavBarItem(index);
            },
            items: [
          BottomNavigationBarItem(icon: Icon(IconBroken.User1) ,label: 'Users'),
          BottomNavigationBarItem(icon: Icon(IconBroken.User) ,label: 'Profile'),
          ],),
          body:HomeCubit.get(context).screens[HomeCubit.get(context).currentIndex]
        );
      },
    );
  }
}
