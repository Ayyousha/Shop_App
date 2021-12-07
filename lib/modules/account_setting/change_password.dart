
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/shared/components/components.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state)
      {
        if(state is UpdatePasswordSuccessState)
        {
          if(state.updatePasswordModels.status!)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.updatePasswordModels.message!}'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.grey[800],
              ),
            );
          } else
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.updatePasswordModels.message!}'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.grey[800],
              ),
            );
          }
        };
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: _buildAppBar(context),
          body: _buildUserBody(context),
        );
      },
    );
  }

  /// App Bar
  PreferredSizeWidget _buildAppBar(context)=> AppBar(
    elevation: 5,
    backgroundColor: HexColor('1a2f3f'),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: HexColor('1a2f3f'),
    ),
    title: Text(
      'Password',
      style: TextStyle(color: Colors.white),
    ),
    titleSpacing: 0,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      splashRadius: 23,
      icon: Icon(
        Icons.arrow_back_outlined,
        color: Colors.white,
      ),
    ),

  );

  /// Body
  Widget _buildUserBody(context) => SingleChildScrollView(
    child: Form(
      key: formKey,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightSizedBox(50),
            /// Current Password
            _buildCurrentPassword(context),
            heightSizedBox(5),
            _buildUserCurrentPasswordTextField(context),
            heightSizedBox(12),
            /// New Password
            _buildNewPassword(context),
            heightSizedBox(5),
            _buildNewPasswordTextField(context),
            heightSizedBox(12),
            /// Confirm Password
            _buildConfirmPassword(context),
            heightSizedBox(5),
            _buildConfirmPasswordTextField(context),
            heightSizedBox(30),
            _buildUpdateButton(context),
          ],
        ),
      ),
    ),
  );

  /// Current Password
  Widget _buildCurrentPassword(context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      'Current Password',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: HexColor('1a2f3f'),
      ),
    ),
  );
  Widget _buildUserCurrentPasswordTextField(context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        prefixIcon: Icon(Icons.lock, color: HexColor('1a2f3f')),
        hintText: "Current Password",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: HexColor('1a2f3f').withOpacity(0.1),
        suffixIcon: IconButton(
          onPressed: () {
            HomeCubit.get(context).changeSuffixCurrentPassword();
          },
          icon: Icon(
            HomeCubit.get(context).suffixOne,
            color: HexColor('1a2f3f').withOpacity(0.8),
          ),
        ),
      ),
      obscureText: HomeCubit.get(context).isPasswordOne,
      controller: currentPasswordController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'UserName is Empty';
        }
        return null;
      },
    ),
  );

  /// New Password
  Widget _buildNewPassword(context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      'New Password',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: HexColor('1a2f3f'),
      ),
    ),
  );
  Widget _buildNewPasswordTextField(context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        prefixIcon: Icon(Icons.lock, color :HexColor('1a2f3f')),
        hintText: "New Password",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: HexColor('1a2f3f').withOpacity(0.1),
        suffixIcon: IconButton(
          onPressed: () {
            HomeCubit.get(context).changeSuffixNewPassword();
          },
          icon: Icon(
            HomeCubit.get(context).suffixTwo,
            color: HexColor('1a2f3f').withOpacity(0.8),
          ),
        ),
      ),
      obscureText: HomeCubit.get(context).isPasswordTwo,
      controller: newPasswordController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email is Empty';
        }
        return null;
      },
    ),
  );

  /// Confirm Password
  Widget _buildConfirmPassword(context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      'Confirm Password',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: HexColor('1a2f3f'),
      ),
    ),
  );
  Widget _buildConfirmPasswordTextField(context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        prefixIcon: Icon(Icons.lock, color: HexColor('1a2f3f')),
        hintText: "Confirm Password",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: HexColor('1a2f3f').withOpacity(0.1),
        suffixIcon: IconButton(
          onPressed: () {
            HomeCubit.get(context).changeSuffixConfirmPassword();
          },
          icon: Icon(
            HomeCubit.get(context).suffixThree,
            color: HexColor('1a2f3f').withOpacity(0.8),
          ),
        ),
      ),
      obscureText: HomeCubit.get(context).isPasswordThree,
      controller: confirmPasswordController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Phone is Empty';
        }
        if(value != newPasswordController.text)
        {
          return 'it\'s not confirm with new password !';
        }
        return null;
      },
    ),
  );

  /// password button update
  Widget _buildUpdateButton(context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: defaultCircularButton(
      height: 40,
      function: ()
      {
        if(formKey.currentState!.validate())
        {
          HomeCubit.get(context).updatePassword(
            CurrentPassword: currentPasswordController.text,
            NewPassword: newPasswordController.text,
            ConfirmPassword: confirmPasswordController.text,
          );
        }
      },
      text: 'Update Profile',
      FontWeight: FontWeight.w900,
      background: HexColor('1a2f3f'),
      isCapital: false,
      rounderRadius: 5,
      // LinearGradient: LinearGradient(
      //   colors: [HexColor('1a2f3f'),HexColor('1a2f3f')],
      // ),
    ),
  );


}
