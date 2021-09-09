import 'dart:io';

import 'package:chat_app/layout/home_cubit/home_cubit.dart';
import 'package:chat_app/layout/home_cubit/home_states.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeLayoutStates>(
      listener: (context, state) {
        if (state is UpdateUserDataSuccessState) {
          // HomeCubit.get(context).profileImage = null;
        }
      },
      builder: (context, state) {
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        var bioController = TextEditingController();
        var profileModel = HomeCubit.get(context).model;
        var profileImage = HomeCubit.get(context).profileImage;
        nameController.text = profileModel.name!;
        phoneController.text = profileModel.phone!;
        bioController.text = profileModel.bio!;
        dynamic widget;
        if (profileImage == null) {
          widget = NetworkImage('${profileModel.image}');
        } else {
          widget = FileImage(profileImage);
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left_2,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              defaultTextButton(
                text: 'update',
                color: Colors.white,
                onPressed: () {
                  HomeCubit.get(context).updateUser(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text);
                },
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
            title: Text(
              '',
              style: TextStyle(fontSize: 20.0),
            ),
            titleSpacing: 2.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  if (state is UpdateUserDataLoadingState)
                    SizedBox(
                      height: 15.0,
                    ),
                  Container(
                    height: 185.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 130.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 63,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: widget,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                HomeCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                radius: 25.0,
                                child: Icon(IconBroken.Camera),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (HomeCubit.get(context).profileImage != null)
                    Row(
                      children: [
                        if (HomeCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(children: [
                              defaultButton(
                                  buttonFunction: () {
                                    HomeCubit.get(context).uploadProfileImage(
                                      phone: phoneController.text,
                                      name: nameController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'Update Profile Image'),
                              if (state is UpdateUserProfileLoadingState)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: LinearProgressIndicator(),
                                ),
                            ]),
                          ),
                        if (HomeCubit.get(context).profileImage !=null)
                          SizedBox(
                            width: 20.0,
                          ),
                        //SizedOverflowBox(size: size)
                      ],
                    ),
                  if (HomeCubit.get(context).profileImage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  Container(
                    height: 60.0,
                    child: defaultTextFormField(
                      controller: nameController,
                      inputType: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) return 'Name must not be empty!';
                        return null;
                      },
                      labelText: '${profileModel.name}',
                      prefix: IconBroken.User,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 60.0,
                    child: defaultTextFormField(
                      controller: phoneController,
                      inputType: TextInputType.phone,
                      labelText: '${profileModel.phone}',
                      prefix: Icons.phone_android_sharp,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 60.0,
                    child: defaultTextFormField(
                      controller: bioController,
                      inputType: TextInputType.text,
                      labelText: '${profileModel.bio}',
                      prefix: IconBroken.User1,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
