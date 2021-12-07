import 'package:moon/models/login_models.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class ChangeSuffixState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModels loginModels;

  LoginSuccessState(this.loginModels);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}
