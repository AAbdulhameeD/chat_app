import 'package:chat_app/layout/home_cubit/home_cubit.dart';
import 'package:chat_app/layout/home_cubit/home_states.dart';
import 'package:chat_app/models/users/create_user.dart';
import 'package:chat_app/modules/chats/chat_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UsersScreen extends StatelessWidget {
  String chatLastMessage='';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeLayoutStates>(
      listener: (context, state) {
        if(state is GetAllUsersErrorState)
          {
          //  chatLastMessage=state.lastMessage;
           HomeCubit.get(context).getAllUsers();
          }
      },
      builder: (context, state) {
        String lastMessage='';
        String date='';
        if (HomeCubit.get(context).allUsers.length > 0  ) {
          return ListView.separated(
            itemBuilder: (context, index) =>
                userBuilder(context, HomeCubit.get(context).allUsers[index],lastMessage,date),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[200],
              ),

            ),
            itemCount: HomeCubit.get(context).allUsers.length,
            physics: BouncingScrollPhysics(),
          );
        } else {


          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
//List<String> lastMessageList=[];
Widget userBuilder(context, UserModel model,lastMessage,date) {
  // print('$lastMessage hgffdgdfg');
  // print('${HomeCubit.get(context).lastMessageSecondMap[model.uId]!.message} llllllll');
  if(HomeCubit.get(context).lastMessageMap[model.uId]!=null){
    lastMessage=HomeCubit.get(context).lastMessageMap[model.uId]!.message;
    if((HomeCubit.get(context).lastMessageMap[model.uId]!.date)!='')
      date=(HomeCubit.get(context).lastMessageMap[model.uId]!.date).toString().replaceRange(4, 7, '');
    print('$date dateeee');
   // print('${DateTime.tryParse(date)} dateeee');
   // print('${DateFormat.yMMMd().add_jm().format(DateTime.tryParse(date)!)}');
    // DateFormat.yMMMd().add_jm().format(DateTime.tryParse(snapshot.data.documents[index].data['timestamp'].toString()));
    
    
  }

  //lastMessageList[index]= HomeCubit.get(context).getLastMessages(receiverId: model.uId!);
  // lastMessage= HomeCubit.get(context).messagesList[HomeCubit.get(context).messagesList.length-1].message!;
  return InkWell(
    onTap: () {
      navigateTo(context, ChatScreen(model));
      print(model.deviceToken);
    },
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Container(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(height: 1.5, fontSize: 16.0),
                  ),
                  Row(
                    children: [
                      Text(
                        '$lastMessage',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.5,
                              fontSize: 12.0,
                            ),
                      ), Spacer(),Text(
                        '$date',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.5,
                              fontSize: 12.0,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
