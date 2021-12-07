import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/models/cart_models.dart';
import 'package:moon/models/home_models.dart';
import 'package:moon/modules/account_setting/change_address.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/components/constance.dart';
import 'package:moon/shared/icon/shop_icon_icons.dart';
import 'cart_details_screen.dart';


class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state)
      {
        if (state is changeFavoritesSuccessState) {
          if (!state.changeFavoritesModel.status!) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Favorite has ${state.changeFavoritesModel.message!}'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.grey[800],
              ),
            );
          } else
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Favorite has ${state.changeFavoritesModel.message!}'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.grey[800],
              ),
            );
          }
        }
        else if (state is addCartSuccessState) {
          if (!state.changeCartsModels.status!)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Cart has ${state.changeCartsModels.message!}'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.grey[800],
              ),
            );
          } else
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Cart has ${state.changeCartsModels.message!}'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.grey[800],
              ),
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: buildAppBar(context),
          body: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(HomeCubit.get(context).cartsModels!.data!.total != 0)
              _buildMyCartItems(context),
              _buildCartListView(context,state),
              if(HomeCubit.get(context).cartsModels!.data!.total != 0)
                _buildCheckoutBar(context),
            ],
          ),
        );
      },
    );
  }


  /// My Cart Items
  Widget _buildMyCartItems(context)=> Container(
    height: 40,
    width: double.infinity,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, bottom: 0),
      child: Row(
        children: [
          Text(
            'My cart items',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          widthSizedBox(10),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey[200]),
            child: Text(
                '  ${HomeCubit.get(context).cartsModels!.data!.cart_items.length}  '),
          ),
        ],
      ),
    ),
  );

  /// Cart List View
  Widget _buildCartListView(context,state) {
    var cubit = HomeCubit.get(context);
    return ConditionalBuilder(
      condition: state is! getCartsLoadingState,
      builder: (context) => Expanded(
        child: ConditionalBuilder(
          condition: cubit.cartsModels!.data!.total != 0,
          builder: (context) {
            return RefreshIndicator(
              onRefresh: HomeCubit.get(context).onRefresh,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              color: HexColor('1a2f3f'),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0, bottom: 5),
                itemCount: cubit.cartsModels!.data!.cart_items.length,
                itemBuilder: (context, index) => buildProductsItems(
                  cubit.cartsModels!.data!.cart_items[index].product!,
                  cubit.homeModels!.data!.Products[index],
                  context,
                  cubit.cartsModels!.data!.cart_items[index],
                ),
              ),
            );
          },
          fallback: (context) => Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: NetworkImage("https://stories.freepiklabs.com/api/vectors/empty/bro/render?color=1A2F3FFF&background=complete&hide="),
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                ),
                heightSizedBox(10),
                Text(
                  'Your cart is empty!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: HexColor('1a2f3f'),
                  ),
                ),
                heightSizedBox(10),
                Text(
                  'It\'s the prefect time to start shopping',
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
      ),
      fallback: (context) =>
          Expanded(child: Center(child: CircularProgressIndicator())),
    );
  }

  /// Products Container
  Widget buildProductsItems(Products model, ProductsModels productsModels, context, CartsData cartsData,) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.amber.withOpacity(0.1),
          splashColor: Colors.amber.withOpacity(0.3),
          onTap: () {
            Navigator.of(context).push(
              CustomPageRoute(
                child: CartDetailsScreen(
                  productsModels: model,
                ),
                direction: AxisDirection.right,
              ),
            );
          },
          child: Row(
            children: [
              widthSizedBox(10),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      width: 100,
                      padding: EdgeInsets.all(10),
                      child: Ink.image(
                        image: NetworkImage('${model.image!}'),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: HexColor('1a2f3f').withOpacity(0.5) ,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            LimitedBox(
                              maxHeight: 30,
                              maxWidth: 30,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: HexColor('1a2f3f') ,
                                  borderRadius: BorderRadius.circular(5),
                                ),

                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(5),
                                    onTap: ()
                                    {
                                      HomeCubit.get(context)
                                          .updateCart(cartsData.product!.id!);
                                      HomeCubit.get(context).getCarts();
                                    },
                                    child: Center(
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '${HomeCubit.get(context).productsQuantity[cartsData.product!.id] != null ? HomeCubit.get(context).productsQuantity[cartsData.product!.id] : cartsData.quantity}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            LimitedBox(
                              maxHeight: 30,
                              maxWidth: 30,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: HomeCubit.get(context).productsQuantity[cartsData.product!.id] == 1 ||
                                      HomeCubit.get(context).productsQuantity[
                                      cartsData.product!.id] ==
                                          null
                                      ?  Colors.grey[400]
                                      : HexColor('1a2f3f'),
                                  borderRadius: BorderRadius.circular(5),
                                ),


                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(5),
                                    onTap:
                                    HomeCubit.get(context).productsQuantity[cartsData.product!.id] == 1 ||
                                        HomeCubit.get(context).productsQuantity[
                                        cartsData.product!.id] ==
                                            null
                                        ?   null
                                        : () {
                                      if (HomeCubit.get(context)
                                          .productsQuantity[cartsData.product!.id] >
                                          1) {
                                        HomeCubit.get(context).updateCart(
                                          cartsData.product!.id!,
                                          increment: false,
                                        );
                                        HomeCubit.get(context).getCarts();
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        '-',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      heightSizedBox(40),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        '${model.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800]),
                      ),
                    ),
                    heightSizedBox(5),
                    /// old price
                    if (model.discount != 0)
                      Row(
                        children: [
                          Text(
                            '${model.old_price!} LE',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              color: Colors.grey,
                            ),
                          ),
                          widthSizedBox(5),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Text(
                              ' Save ${model.old_price! - model.price!} LE (${model.discount!}%) ',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    heightSizedBox(3),
                    /// price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${NumberFormat.currency(decimalDigits: 0, symbol: "").format(model.price!)}',
                          // '${productsModels.price}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: '',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            ' LE',
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: '',
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800]),
                          ),
                        ),
                      ],
                    ),
                    heightSizedBox(5),
                    Row(
                      children: [
                        /// Remove from cart
                        InkWell(
                          highlightColor: HexColor('1a2f3f').withOpacity(0.2),
                          splashColor: HexColor('1a2f3f').withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Remove product from cart?',style: TextStyle(
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
                                      HomeCubit.get(context).putCart(model.id!);
                                      HomeCubit.get(context).getCarts();
                                      HomeCubit.get(context).getHome();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Remove',style: TextStyle(color: Colors.white),),
                                    style:  TextButton.styleFrom(
                                        backgroundColor: Colors.red[700]
                                    ),
                                  ),
                                ],
                              ),
                            );

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  ShopIcon.trash,
                                  color: Colors.redAccent,
                                  size: 12,
                                ),
                                widthSizedBox(3),
                                Text(
                                  'Remove',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        widthSizedBox(20),
                        InkWell(
                          highlightColor: HexColor('1a2f3f').withOpacity(0.2),
                          splashColor: HexColor('1a2f3f').withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            HomeCubit.get(context).putFavorite(model.id!);
                            HomeCubit.get(context).getFavorites();
                            HomeCubit.get(context).putCart(model.id!);
                            HomeCubit.get(context).getCarts();
                            HomeCubit.get(context).getHome();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  ShopIcon.heart,
                                  color: Colors.blue,
                                  size: 12,
                                ),
                                widthSizedBox(3),
                                Text(
                                  'Save for later',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(

                            child:
                            widthSizedBox(10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Checkout Bar
  Widget _buildCheckoutBar(context) {
    return Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              children: [
                Container(
                  color: Colors.grey,
                  height: 0.3,
                  width: double.infinity,
                ),
                heightSizedBox(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${NumberFormat.currency(
                                decimalDigits: 0, symbol: "").format(HomeCubit
                                .get(context)
                                .cartsModels!
                                .data!
                                .total)}',
                            // '${productsModels.price}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 23,
                                fontFamily: '',
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              ' LE',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: '',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800]),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      defaultButton(
                        width: 130,
                        function: () {
                          if (HomeCubit
                              .get(context)
                              .addressModels!
                              .data!
                              .data
                              .length == 0) {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertDialog(
                                    title: const Text(
                                        'Address is not found !!!'),
                                    content: const Text(
                                        'Please add your address and try again.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel',
                                          style: TextStyle(
                                              color: Colors.white),),
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors
                                                .redAccent[700]
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            CustomPageRoute(
                                              child: ChangeAddressScreen(),
                                              direction: AxisDirection.right,
                                            ),
                                          );
                                        },
                                        child: const Text('Add address',
                                          style: TextStyle(
                                              color: Colors.white),),
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.green[700]
                                        ),
                                      ),
                                    ],
                                  ),
                            );
                          } else {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertDialog(
                                    title: const Text('Checkout'),
                                    content: const Text(
                                        'Are you sure you have completed the payment process?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel',
                                          style: TextStyle(
                                              color: Colors.white),),
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors
                                                .redAccent[700]
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          HomeCubit.get(context).addOrder();
                                          HomeCubit.get(context).getCarts();
                                          HomeCubit.get(context).getHome();
                                          Navigator.pop(context, 'Checkout');
                                        },
                                        child: const Text('Checkout',
                                          style: TextStyle(
                                              color: Colors.white),),
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.green[700]
                                        ),
                                      ),
                                    ],
                                  ),
                            );
                          }
                        },
                        radius: 5,
                        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        background: HexColor('1a2f3f'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              ShopIcon.cart,
                              color: Colors.white,
                              size: 17,
                            ),
                            widthSizedBox(5),
                            Text(
                              'checkout',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                heightSizedBox(10),
              ],
            ),
          ),
        );
  }

}
