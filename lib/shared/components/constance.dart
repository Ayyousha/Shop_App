
 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/modules/search/search_screen.dart';
import 'package:moon/modules/starting/starting_screen.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/network/local/cache_helper.dart';

String token = '';

  void logout(context)  async
 {
 await CacheHelper.removeData(key: 'token').then((value)
  {
   if(value)
   {
    Navigator.of(context).pushAndRemoveUntil(
     CustomPageRoute(
      child : StartingScreen(),
      direction: AxisDirection.left,
     ),
         (Route<dynamic> route) => false,
    );
   }
  });

 }


 /// App Bar for all screen
 AppBar buildAppBar(context) => AppBar(
  backgroundColor: HexColor('1a2f3f'),
  systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('1a2f3f'),
      statusBarIconBrightness: Brightness.light),
  toolbarHeight: 60,
  elevation: 0.2,
  shadowColor: Colors.amber,
  leadingWidth: 90,
  titleSpacing: 0,
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
  title: LimitedBox(maxHeight: 40, child: buildSearchingFiled(context)),
 );
 /// Searching in App Bar
 Widget buildSearchingFiled(context) => Padding(
     padding: const EdgeInsets.only(right: 10, left: 5),
     child: Container(
      height: double.infinity,
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(10),
       color: Colors.white,
      ),
      child: Material(
       child: InkWell(
        // borderRadius: BorderRadius.circular(5),
        onTap: ()
        {
         NavigateTo(context, SearchScreen());
        },
        child: Row(
         children: [
          SizedBox(width: 12,),
          Icon(
           Icons.search,
           color: Colors.grey,

          ),
          SizedBox(width: 15,),
          Text(
           "What are you looking for ?",
           style : TextStyle(
            color:  Colors.grey,
            fontSize: 12,
           ),
          ),
         ],
        ),
       ),
      ),
     )
 );