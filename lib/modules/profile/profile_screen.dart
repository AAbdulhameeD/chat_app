import 'package:chat_app/layout/home_cubit/home_cubit.dart';
import 'package:chat_app/layout/home_cubit/home_states.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_profile_screen.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        var profileModel = homeCubit.model;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 185.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 130.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 63,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage('${profileModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${profileModel.name}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.black),
              ),
              Text(
                '${profileModel.bio}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14.0,
                    ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(

                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: Icon(
                        IconBroken.Edit,
                        size: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        signOut(context);
                      },
                      child: Text('logout'),
                    ),
                  ),
                ],
              ),


            ],
          ),
        );
      },
    );
  }
}
