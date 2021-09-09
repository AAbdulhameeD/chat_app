abstract class HomeLayoutStates {}

class HomeLayoutInitialState extends HomeLayoutStates {}

class ChangeNavBarItemState extends HomeLayoutStates {}
class HomeLayoutGetUserLoadingState extends HomeLayoutStates {}
class UpdateDeviceTokenLoadingState extends HomeLayoutStates {}
class UpdateDeviceTokenSuccessState extends HomeLayoutStates {}
class UpdateDeviceTokenErrorState extends HomeLayoutStates {}
class UpdateUserDataLoadingState extends HomeLayoutStates {}
class UpdateUserDataSuccessState extends HomeLayoutStates {}
class UpdateUserDataErrorState extends HomeLayoutStates {}
class HomeLayoutGetUserSuccessState extends HomeLayoutStates {
  final bool hasUser;

  HomeLayoutGetUserSuccessState(this.hasUser);
}
class HomeLayoutGetUserErrorState extends HomeLayoutStates {}
class UpdateUserProfileLoadingState extends HomeLayoutStates {}
class UpdateUserProfileSuccessState extends HomeLayoutStates {}
class UpdateUserProfileErrorState extends HomeLayoutStates {}
class ProfileImageUploadErrorState extends HomeLayoutStates {}
class ProfileImagePickedSuccessState extends HomeLayoutStates {}
class GetAllUsersSuccessState extends HomeLayoutStates {}
class GetAllUsersErrorState extends HomeLayoutStates {}
class SendMessageSuccessState extends HomeLayoutStates {}
class SendMessageErrorState extends HomeLayoutStates {}
class GetMessageSuccessState extends HomeLayoutStates {
  late final String lastMessage;

  GetMessageSuccessState(this.lastMessage);
}
class GetLastMessageSuccessState extends HomeLayoutStates {
}class GetLastMessageErrorState extends HomeLayoutStates {
}
class NewMessageState extends HomeLayoutStates {}
class SendNotificationLoadingState extends HomeLayoutStates {}
