
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/models/contact_models.dart';
import 'package:moon/models/get_order_details_models.dart';
import 'package:moon/modules/contact/web_view.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/icon/shop_icon_icons.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: _buildAppBar(context),
          body: Column(
            children: [
              _buildOrderListView(context,state),
            ],
          ),
        );
      },
    );
  }

  /// App Bar
  PreferredSizeWidget _buildAppBar(context) => AppBar(
    elevation: 5,
    backgroundColor: HexColor('1a2f3f'),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: HexColor('1a2f3f'),
    ),
    title: Row(
      children: [
        Text(
          'Contact',
          style: TextStyle(color: Colors.white),
        ),
      ],
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

  /// Orders List View
  Widget _buildOrderListView(context,state) {
    var cubit = HomeCubit.get(context);
    return Expanded(
      child: ConditionalBuilder(
        condition: HomeCubit.get(context).contactModels!.data!.total! > 0,
        builder: (context) => ListView.separated(
          padding: EdgeInsets.only(top: 15,bottom: 15),
          itemBuilder:(context, index) =>  _buildListOfOrders(cubit.contactModels!.data!.data![index]!,context,state),
          separatorBuilder: (context, index) => SizedBox(height: 15,),
          itemCount: HomeCubit.get(context).contactModels!.data!.data!.length,
        ),
        fallback: (context) => Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage("https://stories.freepiklabs.com/api/vectors/empty/pana/render?color=1A2F3FFF&background=complete&hide="),
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              ),
              heightSizedBox(10),
              Text(
                'No orders yet!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: HexColor('1a2f3f'),
                ),
              ),
              heightSizedBox(10),
              Text(
                'Your orders will show here after buying something',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: HexColor('1a2f3f'),
                ),
              ),
              heightSizedBox(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: OutlinedButton(
                  style: TextButton.styleFrom(
                    side:
                    BorderSide(width: 1.5, color: HexColor('1a2f3f')),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    HomeCubit.get(context)
                        .changeIndex(0);


                  },
                  child: Text(
                    'Continue browsing',
                    style: TextStyle(
                      color: HexColor('1a2f3f'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Orders
  Widget _buildListOfOrders(ContactDataData models,context,state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        // height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: HexColor('1a2f3f'),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Image(
                              image: NetworkImage('${models.image}'),
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            '${models.nameTag.toString()}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 10,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    SizedBox(width: 10,),

                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: ()
                      {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            child : WebViewExampleState(
                              webUrl: '${models.value.toString()}',
                              name: '${models.nameTag.toString()}',
                            ),
                            direction: AxisDirection.right,
                          ),
                        );

                      },
                      child: Text(
                        '${models.value.toString()}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                    
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          )
      ),
    );
  }
}
