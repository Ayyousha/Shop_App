
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/shared/icon/shop_icon_icons.dart';


class ShopLayoutScreen extends StatelessWidget {
  // int _currentPage = 0;
  // final _pageController = PageController();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: _buildBottomNav1(context),
        );
      },
    );
  }

  // BottomNavigationBar _buildBottomNav(context) => BottomNavigationBar(
  //       backgroundColor: HexColor('1a2f3f'),
  //       selectedItemColor: Colors.white,
  //       currentIndex: HomeCubit.get(context).currentIndex,
  //       onTap: (int index) {
  //
  //         HomeCubit.get(context).changeIndex(index);
  //       },
  //       items: [
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             ShopIcon.home,
  //           ),
  //           label: 'Home',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             ShopIcon.laptop_phone,
  //           ),
  //           label: 'Category',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             ShopIcon.tag,
  //           ),
  //           label: 'Deals',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             ShopIcon.user,
  //           ),
  //           label: 'Account',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             ShopIcon.cart,
  //           ),
  //           label: 'Cart',
  //         ),
  //       ],
  //     );


  SnakeNavigationBar _buildBottomNav1(context) => SnakeNavigationBar.color(
     height: 50,
     snakeShape: SnakeShape.rectangle,
     // showSelectedLabels: true,
     // showUnselectedLabels: true,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(10)
    // ),
    // padding: EdgeInsets.symmetric(
    //   horizontal: 3,
    //   vertical: 5
    // ),
     backgroundColor: HexColor('1a2f3f'),
    ///configuration for SnakeNavigationBar.color
    snakeViewColor: Colors.grey[300]!.withOpacity(0.5),
    selectedItemColor:  HexColor('1a2f3f') ,
    // selectedItemColor: SnakeShape.rectangle == SnakeShape.indicator ? HexColor('1a2f3f') : null,
    unselectedItemColor: Colors.white,


    currentIndex: HomeCubit.get(context).currentIndex,
    onTap: (int index) {
      HomeCubit.get(context).changeIndex(index);
    },
    items: [
      BottomNavigationBarItem(icon: Icon(ShopIcon.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(ShopIcon.laptop_phone), label: 'Categories'),
      BottomNavigationBarItem(icon: Icon(ShopIcon.tag), label: 'Deals'),
      BottomNavigationBarItem(icon: Icon(ShopIcon.user), label: 'Account'),
      BottomNavigationBarItem(icon: Icon(ShopIcon.cart), label: 'Cart')
    ],
  );


}
