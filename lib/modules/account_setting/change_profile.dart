
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/shared/components/components.dart';

class ChangeProfileScreen extends StatelessWidget {
  ChangeProfileScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state)
      {
        if(state is UpdateProfileSuccessState)
        {
          if(state.updateUsersModels.status!){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.updateUsersModels.message!}'),
                duration: const Duration(seconds: 3),
                backgroundColor: Colors.grey[800],
              ),
            );
          } else
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.updateUsersModels.message!}'),
                duration: const Duration(seconds: 3),
                backgroundColor: Colors.grey[800],
              ),
            );
          }
        };

      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        userNameController.text = cubit.usersModels!.data!.name!;
        emailController.text = cubit.usersModels!.data!.email!;
        phoneController.text = cubit.usersModels!.data!.phone!;
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
      'Profile',
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
            /// user name
            _buildUserName(context),
            heightSizedBox(5),
            _buildUserNameTextField(),
            heightSizedBox(12),
            /// Email
            _buildEmail(context),
            heightSizedBox(5),
            _buildEmailTextField(),
            heightSizedBox(12),
            /// Phone
            _buildPhone(context),
            heightSizedBox(5),
            _buildPhoneTextField(),
            heightSizedBox(30),
            _buildUpdateButton(context),
          ],
        ),
      ),
    ),
  );

  /// user name
  Widget _buildUserName(context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      'Username',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey[700],
      ),
    ),
  );
  Widget _buildUserNameTextField() => Padding(
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
        prefixIcon: Icon(Icons.person, color: HexColor('1a2f3f')),
        hintText: "Enter your User Name",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: HexColor('1a2f3f').withOpacity(0.1),
      ),
      controller: userNameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'UserName is Empty';
        }
        return null;
      },
    ),
  );

  /// Email
  Widget _buildEmail(context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      'Email',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey[700],
      ),
    ),
  );
  Widget _buildEmailTextField() => Padding(
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
        prefixIcon: Icon(Icons.email, color :HexColor('1a2f3f')),
        hintText: "Enter your Email",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: HexColor('1a2f3f').withOpacity(0.1),
      ),
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email is Empty';
        }
        return null;
      },
    ),
  );

  /// Phone
  Widget _buildPhone(context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      'Phone',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey[700],
      ),
    ),
  );
  Widget _buildPhoneTextField() => Padding(
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
        prefixIcon: Icon(Icons.phone, color: HexColor('1a2f3f')),
        hintText: "Enter your Phone",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: HexColor('1a2f3f').withOpacity(0.1),
      ),
      controller: phoneController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Phone is Empty';
        }
        return null;
      },
    ),
  );

  /// Profile button update
  Widget _buildUpdateButton(context)  {
    var cubit = HomeCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: defaultCircularButton(
        height: 40,
        function: ()
        {
          if(formKey.currentState!.validate()){
            cubit.updateUser(
              name: userNameController.text,
              email: emailController.text,
              phone: phoneController.text,
            );
            cubit.getUser();
          }
        },
        text: 'Update Profile',
        FontWeight: FontWeight.w900,
        // background: Colors.amber[700]!,
        isCapital: false,
        LinearGradient: LinearGradient(
          colors: [HexColor('1a2f3f'), HexColor('1a2f3f')],
        ),
        rounderRadius: 5,
      ),
    );
  }


}
