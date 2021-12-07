import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/shop_layout.dart';
import 'package:moon/modules/login/cubit/cubit.dart';
import 'package:moon/modules/login/cubit/states.dart';
import 'package:moon/modules/register/register_screen.dart';
import 'package:moon/modules/starting/starting_screen.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/components/constance.dart';
import 'package:moon/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModels.status!) {
            CacheHelper.saveData(
                    key: 'token', value: state.loginModels.data!.token)
                .then((value) {
              token = state.loginModels.data!.token!;
              Navigator.of(context).pushAndRemoveUntil(
                CustomPageRoute(
                  child : ShopLayoutScreen(),
                  direction: AxisDirection.left,
                ),
                    (Route<dynamic> route) => false,
              );
              HomeCubit.get(context).currentIndex = 0 ;
              HomeCubit.get(context).getHome();
              HomeCubit.get(context).getCategory();
              HomeCubit.get(context).getFavorites();
              HomeCubit.get(context).getCarts();
              HomeCubit.get(context).getUser();
              HomeCubit.get(context).getAddresses();
            });
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.loginModels.message!}'),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.grey[800],
            ),
          );
        };
      },
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildUserBody(context,state),
        );
      },
    );
  }

  /// App Bar
  PreferredSizeWidget _buildAppBar() => AppBar(
    toolbarHeight: 0,
    backgroundColor: HexColor('1a2f3f').withOpacity(0.8),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
  );

  /// Body
  Widget _buildUserBody(context,state) => SingleChildScrollView(
    child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Back Icon && Login Photo
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: double.infinity,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [HexColor('1a2f3f').withOpacity(0.9),HexColor('1a2f3f').withOpacity(0.5)],
                ),
              ),
              child: IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                    CustomPageRoute(
                      child : StartingScreen(),
                      direction: AxisDirection.left,
                    ),
                        (Route<dynamic> route) => false,
                  );
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  // Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                  semanticLabel: 'Last',
                ),
                splashRadius: 25,
                splashColor: Colors.grey[300],
                highlightColor: Colors.grey[300],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: Container(
                  height: 260,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: HexColor('#fdeca6'),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/login5.png'),
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: defaultCircularButton(
                  function: ()
                  {
                    Navigator.of(context).push(
                      CustomPageRoute(
                        child : RegisterScreen(),
                        direction: AxisDirection.right,
                      ),
                    );
                  },
                  text: 'Sign Up',
                  FontWeight: FontWeight.w900,
                  background: HexColor('1a2f3f'),
                  rounderRadius: 30,
                  isCapital: false,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          /// Email text && Email Text Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Email',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          _buildEmailTextField(context),
          SizedBox(
            height: 10,
          ),
          /// Password text && Password Text Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          _buildPasswordTextField(context),
          SizedBox(
            height: 20,
          ),
          /// Login Button
          if (state is LoginLoadingState)
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(child: CircularProgressIndicator(color: HexColor('1a2f3f'),),)
            ),
          if (state is! LoginLoadingState)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: defaultCircularButton(
              function: () {
                if (formKey.currentState!.validate()) {
                  LoginCubit.get(context).loginUser(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                }
              },
              text: 'Sign In',
              FontWeight: FontWeight.w900,
              // background: Colors.amber[700]!,
              rounderRadius: 5,
              isCapital: false,
              LinearGradient: LinearGradient(
                colors: [HexColor('1a2f3f').withOpacity(0.9),HexColor('1a2f3f').withOpacity(0.5)],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              TextButton(
                onPressed: ()
                {
                  Navigator.of(context).push(
                    CustomPageRoute(
                      child : RegisterScreen(),
                      direction: AxisDirection.right,
                    ),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[300],
                  ),
                ),
              ),
              Text(
                'Now',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  /// Email Text Field
  Widget _buildEmailTextField(context) => Padding(
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
            prefixIcon: Icon(Icons.email, color: HexColor('1a2f3f')),
            hintText: "Enter your Email",
            hintStyle: TextStyle(color: Colors.grey[800]),
            filled: true,
            fillColor: Colors.blue[50],
          ),
          controller: emailController,
          cursorColor: Colors.blue,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email is wrong please try again';
            }
            return null;
          },
        ),
      );

  /// Password Text Field
  Widget _buildPasswordTextField(context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
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
              hintText: "Enter your Password",
              hintStyle: TextStyle(color: Colors.grey[800]),
              filled: true,
              fillColor: Colors.blue[50],
              suffixIcon: IconButton(
                onPressed: () {
                  LoginCubit.get(context).changeSuffix();
                },
                icon: Icon(
                  LoginCubit.get(context).suffix,
                  color: HexColor('1a2f3f'),
                ),
              ),
            ),
            obscureText: LoginCubit.get(context).isPassword,
            cursorColor: Colors.blue,
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password is wrong please try again';
              }
              return null;
            },
          ),
        ),
      );

}

