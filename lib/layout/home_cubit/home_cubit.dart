import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/users/create_user.dart';
import 'package:chat_app/models/users/message_model.dart';
import 'package:chat_app/models/users/notification_model.dart';
import 'package:chat_app/modules/chats/chat_screen.dart';
import 'package:chat_app/modules/profile/profile_screen.dart';
import 'package:chat_app/modules/users/users_screen.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeLayoutStates> {
  HomeCubit() : super(HomeLayoutInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  late UserModel model;

  List<Widget> screens = [
    UsersScreen(),
    ProfileScreen(),
  ];

  void changeNavBarItem(int index) {
    if (index == 0) getAllUsers();
    currentIndex = index;
    emit(ChangeNavBarItemState());
  }
  bool hasUser=false;
  void getUserData() {
    emit(HomeLayoutGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value)  {
      model =  UserModel.fromJson(value.data());
      updateDeviceToken(userDeviceToken: deviceToken);
      hasUser=true;

      emit(HomeLayoutGetUserSuccessState(hasUser));
    }).catchError((error) {
      hasUser=false;

      emit(HomeLayoutGetUserErrorState());
    });
  }

  void updateDeviceToken({required String userDeviceToken}) {
    emit(UpdateDeviceTokenLoadingState());
    UserModel userModel = UserModel(
      name: model.name,
      phone: model.phone,
      bio: model.bio,
      cover: model.cover,
      image: model.image,
      email: model.email,
      uId: model.uId,
      deviceToken: userDeviceToken,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(userModel.toMap(userModel))
        .then((value) {
      //no need to emit state
      emit(UpdateDeviceTokenSuccessState());
    }).catchError((error) {
      emit(UpdateDeviceTokenErrorState());
    });
  }

  late File profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      emit(ProfileImagePickedSuccessState());
    }
  }

  List<UserModel> allUsers = [];
  List<String> allUsersIds = [];
  List<String> lastMessageList = [];
  String lastM ='';
  void getAllUsers() {
    if (allUsers.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model.uId) {
            allUsers.add(UserModel.fromJson(element.data()));
            getLastMessages(receiverId: element.data()['uId']);
           // lastM=getLastMessages(receiverId: element.data()['uId']);
           /*** lastMessageList
                .add(getLastMessages(receiverId: element.data()['uId']));***/
           // print('${lastM}rrrrrrrrrrrr');
          }
          //{
          //   allUsers.add(UserModel.fromJson(element.data()));
          //   //lastMessageList.add(getLastMessages(receiverId: element.data()['uId']));
          //   allUsersIds = element.data()['uId'];
          //   //lastMessageList=getLastMessages(receiverId: element.data()['uId']);
          // }
        });
        emit(GetAllUsersSuccessState());
        //no need to emit state
      }).catchError((error) {
        print('${error.toString()}eeeeeeeeeeeee');
        emit(GetAllUsersErrorState());
      });
  }

  void chatSendMessage({
    required String message,
    required String receiverId,
    required String date,
  }) {
    MessageModel messageModel = MessageModel(
        receiverId: receiverId,
        date: date,
        senderId: model.uId,
        message: message);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap(messageModel))
        .then((value) {
      getLastMessages(receiverId: receiverId);
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model.uId)
        .collection('messages')
        .add(messageModel.toMap(messageModel))
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messagesList = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      messagesList = [];

      event.docs.forEach((element) {
        messagesList.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState(messagesList.length != 0
          ? messagesList[messagesList.length - 1].message
          : "tap to send a message"));
    })
          ..onDone(() {
            emit(NewMessageState());
          });
  }

  //String lastMessage = '';
  MessageModel messageModel=MessageModel(message: 'tap To send a message');
 // Map<String,String> lastMessageMap ={};
  Map<String,MessageModel> lastMessageMap ={};

  void getLastMessages({
    required String receiverId,
  }) {
    print('heeeeee');
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      //print(event.docs.last.data());
      try {
       // lastMessage = event.docs.last.data()['message'];
       // lastMessageMap.addAll({receiverId:lastMessage});

        messageModel=MessageModel.fromJson(event.docs.last.data());
        lastMessageMap.addAll({receiverId:messageModel});
      } catch (e) {
       // lastMessage = "tap to send a message";

         lastMessageMap.addAll({receiverId:MessageModel(message: 'Tap to send a message',receiverId: receiverId,date: ""
         )});

      }
      //print('$lastMessage last message');
      emit(GetLastMessageSuccessState());
    });

  }

  //     .last
  //     .then((value) {
  //       // lastMessage=MessageModel.fromJson()
  // //  print('${value.docs.length} from  last message');
  //   emit(GetLastMessageSuccessState());
  //
  // }).catchError((error) {
  //   emit(GetLastMessageErrorState());
  // });

  NotificationModel? notificationModel;

  void sendNotification({
    required String to,
    required String title,
    String? body,
  }) {
    emit(SendNotificationLoadingState());
    notificationModel = NotificationModel(to: to);
    notificationModel!.androidNotification =
        AndroidNotification(body: body, title: title, sound: "default");
    notificationModel!.android = Android(priority: "HIGH");
    notificationModel!.android!.notification = NotificationSettings(
      defaultLightSettings: true,
      defaultSound: true,
      defaultVibrateTimings: true,
    );
    notificationModel!.android!.data =
        Data(clickAction: "FLUTTER_NOTIFICATION_CLICK");

    // DioHelper.putData(url: SEND, data: notificationModel.toJson())
    //     .then((value) {
    //   print('notify' + value.data.toString());
    //   emit(SendNotificationSuccessState());
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(SendNotificationErrorState());
    // });
  }
}
