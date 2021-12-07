
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/models/get_order_details_models.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/icon/shop_icon_icons.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

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
          'My Orders',
          style: TextStyle(color: Colors.white),
        ),
        widthSizedBox(10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            ' ${HomeCubit.get(context).ordersDetails.length} ',
            style: TextStyle(
              color: HexColor('1a2f3f'),
              fontSize: 20,
            ),
          ),
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
        condition: HomeCubit.get(context).ordersDetails.length > 0,
        builder: (context) => RefreshIndicator(
          onRefresh: HomeCubit.get(context).onRefresh,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          color: HexColor('1a2f3f'),
          child: ListView.separated(
            padding: EdgeInsets.only(top: 15,bottom: 15),
            itemBuilder:(context, index) =>  _buildListOfOrders(cubit.ordersDetails[index].data!,context,state),
            separatorBuilder: (context, index) => SizedBox(height: 15,),
            itemCount: HomeCubit.get(context).ordersDetails.length,
          ),
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
  Widget _buildListOfOrders(OrderDetailsData models,context,state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        // height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: HexColor('1a2f3f'),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        'Order Num : ${models.id.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        models.id.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      Text(
                        models.date!,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 10,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Text(
                    'Cost : ',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    "${NumberFormat.currency(decimalDigits: 0, symbol: "").format(models.cost)} LE",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Vat : ',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    "${NumberFormat.currency(decimalDigits: 0, symbol: "").format(models.vat)} LE",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(width: 10,),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total : ',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            "${NumberFormat.currency(decimalDigits: 0, symbol: "").format(models.total)} LE",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      if(models.status == "New")
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.green,
                            width: 0.5
                          )
                        ),
                        child: Text(
                          ' ${models.status!} ',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      if(models.status == "Cancelled")
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.redAccent,
                            width: 0.5
                          )
                        ),
                        child: Text(
                          ' ${models.status!} ',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  if(models.status == "New")
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: defaultButton(
                      function: ()
                      {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Cancel order from my orders?',style: TextStyle(
                                fontSize: 15
                            ),),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel',style: TextStyle(color: Colors.white,),),
                                style:  TextButton.styleFrom(
                                    backgroundColor: Colors.green[700]
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  HomeCubit.get(context).cancelOrder(id: models.id!);
                                  HomeCubit.get(context).getOrderData();
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel order',style: TextStyle(color: Colors.white),),
                                style:  TextButton.styleFrom(
                                    backgroundColor: Colors.red[700]
                                ),
                              ),
                            ],
                          ),
                        );

                      },
                      width: 100,
                      height: 30,
                      background: Colors.redAccent,
                      child: Row(
                        children: [
                          Icon(
                            ShopIcon.cross,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 3,),
                          Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10,),
            ],
          )
      ),
    );
  }
}
