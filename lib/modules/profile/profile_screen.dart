import 'package:chat_app/shared/components/constants.dart';
import 'package:flutter/material.dart';

class ProfileScreen  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Profile Screen'),
        OutlinedButton(
          onPressed: () {
            signOut(context);
          },
          child: Text('logout'),
        ),
      ],
    );
  }
}
