
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/modules/contact/contact.dart';
import 'package:moon/modules/account_setting/change_account.dart';
import 'package:moon/modules/favorites/favorites_screen.dart';
import 'package:moon/modules/my_order/my_order_screen.dart';
import 'package:moon/modules/search/search_screen.dart';
import 'package:moon/modules/starting/starting_screen.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/components/constance.dart';
import 'package:moon/shared/icon/shop_icon_icons.dart';

class AccountScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
        builder: (context, state) {

          return Scaffold(
            backgroundColor: Colors.grey[200],
            // appBar: _buildAppBar(context),
            body: _buildBody(context,state),
          );
        },
    );
  }

      /// App Bar
  AppBar _buildAppBar(context) => AppBar(
    backgroundColor: HexColor('1a2f3f'),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('1a2f3f'),
            statusBarIconBrightness: Brightness.light),
        elevation: 0,
        shadowColor: Colors.amber,
        leadingWidth: 90,
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 2, left: 3),
          child: Center(
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image(
                image: AssetImage('assets/images/m1.png'),
              ),
            ),
          ),
        ),
      actions: [
        IconButton(
            onPressed: ()
            {
              NavigateTo(context, SearchScreen());
            },
            icon: Icon(
              ShopIcon.magnifier,
              color: Colors.white,
            ),
        ),
        widthSizedBox(5),
      ],
      );

  /// Body
  Widget _buildBody(context,state)=> SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileDetails(context),
        heightSizedBox(10),
        _buildOptionList(context),
        heightSizedBox(10),
        _buildLogout(context,state),
      ],
    ),
  );

  /// profile Details and image
  Widget _buildProfileDetails(context) {
    var cubit = HomeCubit.get(context);
    return Container(
      color: HexColor('1a2f3f'),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20,
          bottom: 15,
          top: 15,
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      // '${cubit.usersModels!.data!.image}'),
                        'https://scontent.fcai21-1.fna.fbcdn.net/v/t1.6435-9/82279133_2475813749336292_5343706101030322176_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=QEA_DZzIYLsAX8UmKX8&tn=6BogoKc8w7X2JeJ1&_nc_ht=scontent.fcai21-1.fna&oh=4e4f1c851b3a597b01761d104e73cd85&oe=61C17991'),
                    radius: 33,
                    backgroundColor: Colors.grey[100],
                  ),
                ),
              ],
            ),
            widthSizedBox(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, ${cubit.usersModels!.data!.name}',
                  style: TextStyle(
                    fontFamily: '',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                heightSizedBox(5),
                Text(
                  'Phone : +02${cubit.usersModels!.data!.phone}',
                  style: TextStyle(
                    fontFamily: '',
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Option list
  Widget _buildOptionList(context) {

    return Column(
      children: [
        Container(
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
                    child : MyOrderScreen(),
                    direction: AxisDirection.right,
                  ),
                );
                HomeCubit.get(context).getOrderData();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                child: Row(
                  children: [
                    Icon(
                      ShopIcon.cart,
                      color: HexColor('1a2f3f'),
                      size: 25,
                    ),
                    widthSizedBox(25),
                    Text(
                      'My Orders',
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
        ),
        MyDivider(),
        Container(
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
                    child : FavoritesScreen(),
                    direction: AxisDirection.right,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                child: Row(
                  children: [
                    Icon(
                      ShopIcon.heart,
                      color: HexColor('1a2f3f'),
                      size: 25,
                    ),
                    widthSizedBox(25),
                    Text(
                      'Favorites',
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
        ),
        MyDivider(),
        Container(
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
                    child : ChangeAccountScreen(),
                    direction: AxisDirection.right,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                child: Row(
                  children: [
                    Icon(
                      ShopIcon.cog,
                      color: HexColor('1a2f3f'),
                      size: 25,
                    ),
                    widthSizedBox(25),
                    Text(
                      'Account Setting',
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
        ),
        MyDivider(),
        Container(
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
                    child : ContactScreen(),
                    direction: AxisDirection.right,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                child: Row(
                  children: [
                    Icon(
                      ShopIcon.question_circle,
                      color: HexColor('1a2f3f'),
                      size: 25,
                    ),
                    widthSizedBox(25),
                    Text(
                      'Contact',
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
        ),

      ],
    );
  }

  /// Logout
  Widget _buildLogout(context,state)  {

    return  Column(
      children: [
        if(state is logoutLoadingState)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Center(child: CircularProgressIndicator(color: Colors.redAccent,),),
          ),
        if(state is! logoutLoadingState)
        Container(
          color: Colors.white,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.redAccent.withOpacity(0.1),
              splashColor: Colors.redAccent.withOpacity(0.2),
              onTap: ()
              {
                HomeCubit.get(context).logoutUser();
                logout(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                child: Row(
                  children: [
                    Icon(
                      ShopIcon.exit,
                      color: Colors.redAccent,
                      size: 25,
                    ),
                    widthSizedBox(25),
                    Text(
                      'Log out',
                      style: TextStyle(
                          color: Colors.redAccent
                      ),

                    ),
                    Spacer(),
                    Icon(
                      ShopIcon.chevron_right,
                      color: Colors.redAccent,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}


