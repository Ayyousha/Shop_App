


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon/models/login_models.dart';
import 'package:moon/models/register_models.dart';
import 'package:moon/modules/register/cubit/states.dart';
import 'package:moon/shared/components/constance.dart';
import 'package:moon/shared/network/end_pointing.dart';
import 'package:moon/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);


  LoginModels? loginModels;
 void registerUser({
  required String userName,
  required String email,
  required String password,
  required String phone,
})
 {
   emit(RegisterLoadingState());
   DioHelper.postData(
       url: register,
       data:
       {
        'name':userName,
        'email':email,
        'password':password,
        'phone':phone,
       },
   ).then((value)
   {
     loginModels = LoginModels.fromJson(value.data);
     emit(RegisterSuccessState(loginModels!));
   }).catchError((error)
   {
     print(error.toString());
     emit(RegisterErrorState(error.toString()));
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