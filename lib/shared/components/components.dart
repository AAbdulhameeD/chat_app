import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';

Widget defaultAppBar(
    BuildContext context,
    {
      String? title,
      List<Widget>? actions,
    }
    ) =>
    AppBar(
      leading: IconButton(
        icon: Icon(
          IconBroken.Arrow___Left_2,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: actions,
      title: Text(title!,style: TextStyle(fontSize: 20.0),),
      titleSpacing: 2.0,
    );
Widget defaultTextButton(
    {
      required Function onPressed,
      required String text,

    }
    )=>TextButton(onPressed: (){
      onPressed();
}, child: Text(text.toUpperCase(),style: TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.bold

),));
void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
          (Route<dynamic> route) => false);
}
Widget defaultButton({
  required Function buttonFunction,
  required String text,
  Color color = Colors.blue,
  double width = double.infinity,
  double radius = 5.0,
  double height = 20.0,
  bool isUpperCase = true,
}) =>
    Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      child: MaterialButton(
        height: height,
        onPressed: (){
          buttonFunction();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType inputType,
  Function? fieldSubmitted,
  Function? validate,
  required String labelText,
  Function? onChanged,
  required IconData prefix,
  Function? onTappedTextForm,
  IconData? suffix,
  bool isPassword = false,
  Function? showPassword,
}) =>
    TextFormField(
      keyboardType: inputType,
      controller: controller,

      validator: (value){
        validate!(value);
      },
      // onTap: onTappedTextForm,
      //     (value) {
      //   if (value.isEmpty) {
      //     return 'Email Address is required';
      //   }
      //   return null;
      // },
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          icon: Icon(suffix),
          onPressed: (){
            showPassword!();
          },
        )
            : null,
        //
        // suffix != null
        //     ? Icon(
        //         suffix,
        //       )
        //     : null,
      ),
    );