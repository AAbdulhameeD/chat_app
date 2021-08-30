import 'package:chat_app/layout/home_cubit/home_cubit.dart';
import 'package:chat_app/layout/home_cubit/home_states.dart';
import 'package:chat_app/models/users/create_user.dart';
import 'package:chat_app/models/users/message_model.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  late final UserModel userModel;

  ChatScreen(this.userModel);

  var messageController = TextEditingController();
  var scrollController = ScrollController(initialScrollOffset: 75000);

  final dateFormat = DateFormat.jms().add_yMd();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        HomeCubit.get(context)
            .getMessages(receiverId: userModel.uId.toString());
        // HomeCubit.get(context)
        //     .getLastMessages(receiverId: userModel.uId.toString());

        //   userModel.lastMessage=HomeCubit.get(context).messagesList[HomeCubit.get(context).messagesList.length-1].message.toString();
        return BlocConsumer<HomeCubit, HomeLayoutStates>(
          listener: (context, state) {
            if (state is GetMessageSuccessState) {}
            if (scrollController.hasClients)
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );
          },
          builder: (context, state) {
            return Scaffold(
                backgroundColor: Colors.green.shade50,
                appBar: AppBar(
                  elevation: 2.0,
                  leading: IconButton(
                    icon: Icon(
                      IconBroken.Arrow___Left_2,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        '${userModel.name}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                body: HomeCubit.get(context).messagesList.length > 0
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.manual,
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                var message =
                                    HomeCubit.get(context).messagesList[index];
                                // lastMessage=message.message.toString();
                                //  print(HomeCubit.get(context).messagesList[HomeCubit.get(context).messagesList.length-1].message);
                                if (HomeCubit.get(context).model.uId ==
                                    message.senderId)
                                  return sentMessage(message, context);
                                return receivedMessage(message, context);
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10.0,
                              ),
                              itemCount:
                                  HomeCubit.get(context).messagesList.length,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Container(
                                height: 80.0,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                        child: TextFormField(
                                      controller: messageController,
                                      decoration: InputDecoration(
                                        hintText: 'Type a message..',
                                        hintStyle: TextStyle(
                                          fontSize: 16.0,
                                          height: 1.1,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: IconButton(
                                          onPressed: () {
                                            HomeCubit.get(context)
                                                .chatSendMessage(
                                              message: messageController.text,
                                              receiverId:
                                                  userModel.uId.toString(),
                                              date: dateFormat
                                                  .format(DateTime.now()),
                                            );
                                            HomeCubit.get(context)
                                                .sendNotification(
                                                    to: userModel.deviceToken
                                                        .toString(),
                                                    title: userModel.name
                                                        .toString(),
                                                    body:
                                                        messageController.text);
                                            print(userModel.deviceToken);
                                            messageController.clear();
                                          },
                                          color: defaultColor,
                                          icon: Icon(IconBroken.Send)),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                                child: Align(
                                    alignment: AlignmentDirectional.center,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Text(
                                          'There is no messages yet between you and ${userModel.name}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[500]
                                          ),
                                        ),
                                      ),
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Container(
                                height: 80.0,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                        child: TextFormField(
                                      controller: messageController,
                                      decoration: InputDecoration(
                                        hintText: 'Type a message..',
                                        hintStyle: TextStyle(
                                          fontSize: 16.0,
                                          height: 1.1,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: IconButton(
                                          onPressed: () {
                                            HomeCubit.get(context)
                                                .chatSendMessage(
                                              message: messageController.text,
                                              receiverId:
                                                  userModel.uId.toString(),
                                              date: dateFormat
                                                  .format(DateTime.now()),
                                            );
                                            HomeCubit.get(context)
                                                .sendNotification(
                                                    to: userModel.deviceToken
                                                        .toString(),
                                                    title: userModel.name
                                                        .toString(),
                                                    body:
                                                        messageController.text);
                                            print(userModel.deviceToken);
                                            messageController.clear();
                                          },
                                          color: defaultColor,
                                          icon: Icon(IconBroken.Send)),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )

                // ConditionalBuilder(
                //   condition: HomeCubit.get(context).messagesList.length > 0,
                //   fallback: (context) =>
                //       Center(child: CircularProgressIndicator()),
                //   builder: (context) => Column(
                //     children: [
                //       Expanded(
                //         child: ListView.separated(
                //           keyboardDismissBehavior:
                //           ScrollViewKeyboardDismissBehavior.manual,
                //           controller: scrollController,
                //           itemBuilder: (context, index) {
                //             var message =
                //             HomeCubit.get(context).messagesList[index];
                //             if (HomeCubit.get(context).model.uId ==
                //                 message.senderId)
                //               return sentMessage(message, context);
                //             return receivedMessage(message, context);
                //           },
                //           separatorBuilder: (context, index) => SizedBox(
                //             height: 10.0,
                //           ),
                //           itemCount: HomeCubit.get(context).messagesList.length,
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 15.0, vertical: 5.0),
                //         child: Container(
                //           height: 45.0,
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               border: Border.all(
                //                 width: 1.0,
                //                 color: Colors.grey[300],
                //               ),
                //               borderRadius: BorderRadius.circular(15.0)),
                //           clipBehavior: Clip.antiAliasWithSaveLayer,
                //           child: Container(
                //             height: 80.0,
                //             child: Row(
                //               children: [
                //                 SizedBox(
                //                   width: 5.0,
                //                 ),
                //                 Expanded(
                //                     child: TextFormField(
                //                       controller: messageController,
                //                       decoration: InputDecoration(
                //                         hintText: 'Type a message..',
                //                         hintStyle: TextStyle(
                //                           fontSize: 16.0,
                //                           height: 1.1,
                //                         ),
                //                         border: InputBorder.none,
                //                       ),
                //                     )),
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 12.0),
                //                   child: IconButton(
                //                       onPressed: () {
                //                         HomeCubit.get(context).chatSendMessage(
                //                           message: messageController.text,
                //                           receiverId: userModel.uId,
                //                           date:
                //                           dateFormat.format(DateTime.now()),
                //                         );
                //                         HomeCubit.get(context).sendNotification(
                //                             to: userModel.deviceToken,
                //                             title: userModel.name,
                //                             body: messageController.text);
                //                         print(userModel.deviceToken);
                //                         messageController.clear();
                //                       },
                //                       color: defaultColor,
                //                       icon: Icon(IconBroken.Send)),
                //                 ),
                //                 SizedBox(
                //                   width: 15.0,
                //                 )
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
                );
          },
        );
      },
    );
  }

  Widget receivedMessage(MessageModel message, context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0),
                topLeft: Radius.circular(50.0),
              )),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                      '${message.message}',
                      maxLines: 30,
                      textWidthBasis: TextWidthBasis.longestLine,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Text(
                        '${(message.date).toString().replaceRange(4, 7, '')}',
                        maxLines: 30,
                        textWidthBasis: TextWidthBasis.longestLine,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget sentMessage(MessageModel message, context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
                color: defaultColor.withOpacity(.2),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50.0),
                  bottomLeft: Radius.circular(50.0),
                  topLeft: Radius.circular(50.0),
                )),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Text(
                        '${message.message}',
                        maxLines: 30,
                        textWidthBasis: TextWidthBasis.longestLine,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Text(
                          '${(message.date).toString().replaceRange(4, 7, '')}',
                          maxLines: 30,
                          textWidthBasis: TextWidthBasis.longestLine,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption),
                    ),
                  ),
                ]),
          ),
        ),
      );
}
