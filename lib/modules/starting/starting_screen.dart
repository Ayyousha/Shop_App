
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/modules/login/login_screen.dart';
import 'package:moon/modules/register/register_screen.dart';
import 'package:moon/shared/components/components.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          /// Head Text
          _buildHeadText(),
          heightSizedBox(20.0),
          /// Image
          _buildImage(),
          heightSizedBox(40.0),
          /// Create Account Button
          _buildRegisterButton(context),
          heightSizedBox(10.0),
          /// Sign In Button
          _buildSignInButton(context),
        ],
      ),
    );
  }

  /// Head Text
  Widget _buildHeadText()=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
    child: Text(
      'Online Shopping Application',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.bold,
          fontSize: 35
      ),
    ),
  );

  /// Image
  Widget _buildImage()=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
    child: Image(
      // image: NetworkImage('https://stories.freepiklabs.com/api/vectors/add-to-cart/pana/render?color=1A2F3FFF&background=complete&hide='),
      image: AssetImage('assets/images/start.png'),
    ),
  );

  /// Create Account Button
  Widget _buildRegisterButton(context)=> Padding(
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
      text: 'Create Account',
      FontWeight: FontWeight.w900,
      // background: Colors.amber[700]!,
      rounderRadius: 30,
      isCapital: false,
      LinearGradient: LinearGradient(
        colors: [Colors.amber[200]!,Colors.amber[800]!],
      ),
    ),
  );

  /// Sign In Button
  Widget _buildSignInButton(context)=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: defaultCircularButton(
      function: ()
      {
        Navigator.of(context).push(
          CustomPageRoute(
            child : LoginScreen(),
            direction: AxisDirection.right,
          ),
        );
      },
      text: 'Sign In',
      // TextColor: Colors.grey[700],
      TextColor: Colors.white,
      FontWeight: FontWeight.w900,
      // background: Colors.grey[200]!,
      rounderRadius: 30,
      isCapital: false,
      LinearGradient: LinearGradient(
        colors: [HexColor('1a2f3f').withOpacity(0.5),HexColor('1a2f3f').withOpacity(0.9)],
      ),
    ),
  );

}


