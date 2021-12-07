

import 'package:moon/models/login_models.dart';
import 'package:moon/models/register_models.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class ChangeSuffixState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModels loginModels;

  RegisterSuccessState(this.loginModels);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}
