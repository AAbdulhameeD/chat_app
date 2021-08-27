class MessageModel {
  String? senderId;
  String? receiverId;
  String message='tap to send a message';
  String? date;
  // DateTime? dateTime;


  MessageModel({this.senderId,this.receiverId,required this.message,this.date});
  MessageModel.fromJson(dynamic json){
    senderId=json['senderId'];
    receiverId=json['receiverId'];
    message=json['message'];
    date=json['date'];

  }
  Map<String,dynamic> toMap(MessageModel userModel){
    return {
      'senderId':userModel.senderId,
      'receiverId':userModel.receiverId,
      'message':userModel.message,
      'date':userModel.date,

    };
  }

}