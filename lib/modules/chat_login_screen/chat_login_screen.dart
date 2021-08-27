
import 'package:chat_app/layout/home_layout.dart';
import 'package:chat_app/modules/chat_login_screen/chat_cubit/cubit.dart';
import 'package:chat_app/modules/chat_login_screen/chat_cubit/states.dart';
import 'package:chat_app/modules/social_register/chat_register_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/network/local/dio_helper.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void validateAndLogin(context) {
    if (formKey.currentState!.validate()) {
      // print(emailController.text);
      // print(passwordController.text);
      LoginCubit.get(context).userLogin(
          email: emailController.text, password: passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, ChatLoginCubitStates>(
        listener: (context, state) {
          if (state is ChatLoginSuccessState) {
            CacheHelper.putData(key: 'uId', value: state.uId);
            navigateAndFinish(context, ChatHomeLayout());
          }
          if (state is CreateUserSuccessState) {
            CacheHelper.putData(key: 'uId', value: state.uId);
            navigateAndFinish(context, ChatHomeLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Communicate with your friends.',
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
                            fieldSubmitted: (value) {
                              print(value.toString());
                            },
                            controller: passwordController,
                            inputType: TextInputType.visiblePassword,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please  insert your password';
                              }
                            },
                            labelText: 'Password',
                            prefix: Icons.lock_outline,
                            isPassword: LoginCubit.get(context).isPassword,
                            suffix: LoginCubit.get(context).suffix,
                            showPassword: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibilityState();
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        // ConditionalBuilder(
                        //   condition: state is! ChatLoginLoadingState,
                        //   builder: (context) => defaultButton(
                        //       buttonFunction: () {
                        //         validateAndLogin(context);
                        //       },
                        //       text: 'Login',
                        //       height: 50.0),
                        //   fallback: (context) =>
                        //       Center(child: CircularProgressIndicator()),
                        // ),
                        ( state is! ChatLoginLoadingState)?defaultButton(
                                buttonFunction: () {
                                  validateAndLogin(context);
                                },
                                text: 'Login',
                                height: 50.0):Center(child: CircularProgressIndicator()),
                        SizedBox(
                          height: 20.0,
                        ),
                        // ConditionalBuilder(
                        //   condition: state is! GoogleLoginLoadingState,
                        //   builder: (context) => defaultButton(
                        //       buttonFunction: () {
                        //         LoginCubit.get(context).googleLogin();                              },
                        //       text: 'Google Login',
                        //       height: 50.0),
                        //   fallback: (context) =>
                        //       Center(child: CircularProgressIndicator()),
                        // ),
                        (state is! GoogleLoginLoadingState)?defaultButton(
                                buttonFunction: () {
                                  LoginCubit.get(context).googleLogin();                              },
                                text: 'Google Login',
                                height: 50.0):Center(child: CircularProgressIndicator()),

                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 15.0,
                                  ),
                            ),
                            TextButton(
                              onPressed: () {
                               navigateTo(context, ChatRegisterScreen());
                              },
                              child: Text(
                                'Register now',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 15.0, color: defaultColor),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
