
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/shop_layout.dart';
import 'package:moon/modules/login/login_screen.dart';
import 'package:moon/modules/register/cubit/cubit.dart';
import 'package:moon/modules/register/cubit/states.dart';
import 'package:moon/modules/starting/starting_screen.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/components/constance.dart';
import 'package:moon/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state)
        {
          if(state is RegisterSuccessState)
          {
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
          }
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
    backgroundColor: HexColor('#fdeca6'),
  );

  /// Body
  Widget _buildUserBody(context,state) => SingleChildScrollView(
    child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Register Image
          SizedBox(height: 15,),
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Container(
                    height: 150,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: HexColor('#fdeca6'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image(
                      image: AssetImage('assets/images/register1.png'),
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [Colors.amber[800]!,Colors.amber[200]!],
                    ),
                  ),
                  child: IconButton(
                    onPressed: ()
                    {
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
                      color: Colors.white,
                      semanticLabel: 'Last',
                    ),
                    splashRadius: 25,
                    splashColor: Colors.grey[100],
                    highlightColor: Colors.grey[100],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          /// Name text && Name Text Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Username',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: 5,),
          _buildUserNameTextField(),
          SizedBox(height: 12,),
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
          SizedBox(height: 5,),
          _buildEmailTextField(),
          SizedBox(height: 12,),
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
          SizedBox(height: 5,),
          _buildPasswordTextField(context),
          SizedBox(height: 12,),
          /// Phone text && Phone Text Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Phone',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: 5,),
          _buildPhoneTextField(),
          SizedBox(height: 25,),
          /// Register Button
          if (state is RegisterLoadingState)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(child: CircularProgressIndicator(color: Colors.amber,),)
            ),
          if (state is! RegisterLoadingState)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: defaultCircularButton(

              function: ()
              {
                if(formKey.currentState!.validate())
                {
                  RegisterCubit.get(context).registerUser(
                    userName: userNameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    phone: phoneController.text,
                  );
                }
              },
              text: 'Sign Up',
              FontWeight: FontWeight.w900,
              // background: Colors.amber[700]!,
              rounderRadius: 5,
              isCapital: false,
              LinearGradient: LinearGradient(
                colors: [Colors.amber[800]!,Colors.amber[200]!],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You already have an email ',
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
                      child : LoginScreen(),
                      direction: AxisDirection.right,
                    ),
                  );
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber[300],
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

  /// UserName Text Field
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
        prefixIcon: Icon(Icons.person, color: Colors.amber),
        hintText: "Enter your User Name",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: Colors.amber[50],
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

  /// Email Text Field
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
        prefixIcon: Icon(Icons.email, color: Colors.amber),
        hintText: "Enter your Email",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: Colors.amber[50],
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
          prefixIcon: Icon(Icons.lock, color: Colors.amber),
          hintText: "Enter your Password",
          hintStyle: TextStyle(color: Colors.grey[800]),
          filled: true,
          fillColor: Colors.amber[50],
          suffixIcon: IconButton(
            onPressed: () {
              RegisterCubit.get(context).changeSuffix();
            },
            icon: Icon(
              RegisterCubit.get(context).suffix,
              color: Colors.amber,
            ),
          ),
        ),
        controller: passwordController,
        obscureText: RegisterCubit.get(context).isPassword,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Password is Empty';
          }
          return null;
        },
      ),
    ),
  );

  /// Phone Text Field
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
        prefixIcon: Icon(Icons.phone, color: Colors.amber),
        hintText: "Enter your Phone",
        hintStyle: TextStyle(color: Colors.grey[800]),
        filled: true,
        fillColor: Colors.amber[50],
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


}
