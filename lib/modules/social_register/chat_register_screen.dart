

import 'package:chat_app/modules/social_register/register_cubit/cubit.dart';
import 'package:chat_app/modules/social_register/register_cubit/states.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ChatRegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late String userToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => ChatRegisterCubit(),
        child: BlocConsumer<ChatRegisterCubit, ChatRegisterCubitStates>(
          listener: (context, state) {
            if(state is ChatCreateUserSuccessState){
              // CacheHelper.putData(key: 'uId', value:state.uId );
              // navigateAndFinish(context, ChatHomeScreen());
            }
          },
          builder: (context, state) {
            // final Future<FirebaseApp> initialization = Firebase.initializeApp();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Register and find new friends',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: Colors.grey,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: nameController,
                          inputType: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please  insert your name';
                            }
                          },
                          labelText: 'Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          inputType: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please  insert your e-mail address';
                            }
                          },
                          labelText: 'Email address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          inputType: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please  insert your password';
                            }
                            return null;
                          },
                          labelText: 'Password',
                          prefix: Icons.lock_outline,
                          isPassword:
                              ChatRegisterCubit.get(context).isPassword,
                          suffix: ChatRegisterCubit.get(context).suffix,
                          showPassword: () {
                            ChatRegisterCubit.get(context)
                                .changePasswordVisibilityState();
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          controller: phoneController,
                          inputType: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please  insert your Phone number';
                            }
                          },
                          labelText: 'Phone Number',
                          prefix: Icons.phone_android_sharp,
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        // ConditionalBuilder(
                        //   condition: state is! ChatRegisterLoadingState,
                        //   builder: (context) => defaultButton(
                        //       buttonFunction: () {
                        //         validateAndLogin(context);
                        //       },
                        //       text: 'Register',
                        //       height: 60.0),
                        //   fallback: (context) =>
                        //       Center(child: CircularProgressIndicator()),
                        // ),
                        (state is! ChatRegisterLoadingState)?defaultButton(
                                buttonFunction: () {
                                  validateAndLogin(context);
                                },
                                text: 'Register',
                                height: 60.0):Center(child: CircularProgressIndicator())
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void validateAndLogin(context) {
    if (formKey.currentState!.validate()) {
      ChatRegisterCubit.get(context).userRegister(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phone: phoneController.text,
      );
    }
  }
}
