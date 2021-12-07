
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/modules/account_setting/change_address.dart';
import 'package:moon/modules/account_setting/change_password.dart';
import 'package:moon/modules/account_setting/change_profile.dart';
import 'package:moon/modules/favorites/favorites_screen.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/icon/shop_icon_icons.dart';

class ChangeAccountScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return Scaffold(
            appBar: _buildAppBar(context),
            backgroundColor: Colors.grey[200],
            body: _buildBody(context),
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
      'Account Settings',
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
  Widget _buildBody(context)=> Column(
    children: [
      _buildProfile(context),
      MyDivider(),
      _buildPassword(context),
      MyDivider(),
      _buildAddress(context),

    ],
  );

  /// Profile
  Widget _buildProfile(context)=> Container(
    color: Colors.white,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: HexColor('1a2f3f').withOpacity(0.1),
        splashColor: HexColor('1a2f3f').withOpacity(0.2),
        onTap: ()
        {
          Navigator.of(context).push(
            CustomPageRoute(
              child : ChangeProfileScreen(),
              direction: AxisDirection.right,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
          child: Row(
            children: [
              Icon(
                ShopIcon.user,
                color: HexColor('1a2f3f'),
                size: 25,
              ),
              widthSizedBox(25),
              Text(
                'Profile',
                style: TextStyle(
                  color: HexColor('1a2f3f'),
                ),
              ),
              Spacer(),
              Icon(
                ShopIcon.chevron_right,
                color: HexColor('1a2f3f'),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    ),
  );

  /// Password
  Widget _buildPassword(context)=> Container(
    color: Colors.white,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: HexColor('1a2f3f').withOpacity(0.1),
        splashColor: HexColor('1a2f3f').withOpacity(0.2),
        onTap: ()
        {
          Navigator.of(context).push(
            CustomPageRoute(
              child : ChangePasswordScreen(),
              direction: AxisDirection.right,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
          child: Row(
            children: [
              Icon(
                ShopIcon.lock,
                color: HexColor('1a2f3f'),
                size: 25,
              ),
              widthSizedBox(25),
              Text(
                'Password',
                style: TextStyle(
                  color: HexColor('1a2f3f'),
                ),
              ),
              Spacer(),
              Icon(
                ShopIcon.chevron_right,
                color: HexColor('1a2f3f'),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    ),
  );

  /// Address
  Widget _buildAddress(context)=> Container(
    color: Colors.white,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: HexColor('1a2f3f').withOpacity(0.1),
        splashColor: HexColor('1a2f3f').withOpacity(0.2),
        onTap: ()
        {
          Navigator.of(context).push(
            CustomPageRoute(
              child : ChangeAddressScreen(),
              direction: AxisDirection.right,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
          child: Row(
            children: [
              Icon(
                ShopIcon.location,
                color: HexColor('1a2f3f'),
                size: 25,
              ),
              widthSizedBox(25),
              Text(
                'Address',
                style: TextStyle(
                  color: HexColor('1a2f3f'),
                ),
              ),
              Spacer(),
              Icon(
                ShopIcon.chevron_right,
                color: HexColor('1a2f3f'),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    ),
  );

}



