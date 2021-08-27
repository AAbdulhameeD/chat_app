class UserModel {
  String? name;
  String? email;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  String? lastMessage;
  String? uId;
  String? deviceToken;
  UserModel({this.name,this.email,this.phone,this.uId,this.bio,this.image,this.cover,this.deviceToken});
  UserModel.fromJson(dynamic json){
    name=json['name'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    lastMessage=json['lastMessage'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    deviceToken=json['deviceToken'];
  }
  Map<String,dynamic> toMap(UserModel userModel){
    return {
      'name':userModel.name,
      'image':userModel.image,
      'cover':userModel.cover,
      'bio':userModel.bio,
      'lastMessage':userModel.lastMessage,
      'email':userModel.email,
      'phone':userModel.phone,
      'uId':userModel.uId,
      'deviceToken':userModel.deviceToken,
    };
  }

}