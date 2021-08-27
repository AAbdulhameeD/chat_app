abstract class ChatLoginCubitStates {}

class ChatInitialStates extends ChatLoginCubitStates {}

class ChatPasswordVisibilityState extends ChatLoginCubitStates {}

class ChatLoginSuccessState extends ChatLoginCubitStates {
  final dynamic uId;

  ChatLoginSuccessState(this.uId);
}

class ChatLoginErrorState extends ChatLoginCubitStates {}

class GoogleLoginLoadingState extends ChatLoginCubitStates {}

class GoogleLoginSuccessState extends ChatLoginCubitStates {
  final dynamic uId;

  GoogleLoginSuccessState(this.uId);
}

class GoogleLoginErrorState extends ChatLoginCubitStates {}

class CreateGoogleUserLoadingState extends ChatLoginCubitStates {}

class CreateUserSuccessState extends ChatLoginCubitStates {
  final dynamic uId;

  CreateUserSuccessState(this.uId);
}

class CreateGoogleUserErrorState extends ChatLoginCubitStates {}


class ChatLoginLoadingState extends ChatLoginCubitStates {}
