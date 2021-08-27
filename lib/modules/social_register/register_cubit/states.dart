abstract class ChatRegisterCubitStates {}

class ChatRegisterInitialState extends ChatRegisterCubitStates {}

class ChatRegisterPasswordVisibilityState extends ChatRegisterCubitStates {}

class ChatRegisterLoadingState extends ChatRegisterCubitStates {}

class ChatRegisterSuccessState extends ChatRegisterCubitStates {}

class ChatRegisterErrorState extends ChatRegisterCubitStates {}

class ChatCreateUserSuccessState extends ChatRegisterCubitStates {
  final dynamic uId;

  ChatCreateUserSuccessState(this.uId);
}

class ChatCreateUserErrorState extends ChatRegisterCubitStates {}
