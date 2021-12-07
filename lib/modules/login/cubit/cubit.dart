
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon/models/login_models.dart';
import 'package:moon/modules/login/cubit/states.dart';
import 'package:moon/shared/network/end_pointing.dart';
import 'package:moon/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);


  LoginModels? loginModels;
 void loginUser({
  required String email,
  required String password,
})
 {
   emit(LoginLoadingState());
   DioHelper.postData(
       url: Login,
       data:
    {
        'email' :  email,
        'password' :  password,
    }
   ).then((value)
   {
     print(value);
     loginModels = LoginModels.fromJson(value.data);
     emit(LoginSuccessState(loginModels!));
   }).catchError((error)
   {
     emit(LoginErrorState(error.toString()));
     print('Catching Error is (((( ${error.toString()} ))))');
   });
 }


  bool isPassword = false;
  IconData suffix = Icons.visibility_outlined;
  void changeSuffix()
  {
    isPassword = !isPassword ;
    suffix = isPassword ?  Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeSuffixState());
  }

}