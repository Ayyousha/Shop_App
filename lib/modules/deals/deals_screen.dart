import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/models/home_models.dart';
import 'package:moon/modules/home/products_details_screen.dart';
import 'package:moon/modules/search/search_screen.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/components/constance.dart';
import 'package:moon/shared/icon/shop_icon_icons.dart';

class DealsScreen extends StatelessWidget {
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
          backgroundColor: Colors.grey[200],
          appBar: buildAppBar(context),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSuperDealsTitle(),
              _buildDealsListView(context),
            ],
          ),
        );
      },
    );
  }


  /// Super Deals title
  Widget _buildSuperDealsTitle() => Padding(
    padding: const EdgeInsets.only(right: 8, left: 8, top: 5,bottom: 5),
    child: Container(
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 3, left: 5),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Super',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.grey[800]),
            ),
            TextSpan(
              text: ' Deals',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.redAccent),
            ),
          ]),
        ),
      ),
    ),
  );

  /// Deals List View
  Widget _buildDealsListView(context) {
    var cubit = HomeCubit.get(context);
    return ConditionalBuilder(
      condition: cubit.homeModels != null,
      builder: (context) => Expanded(
        child: RefreshIndicator(
          onRefresh: HomeCubit.get(context).onRefresh,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          color: HexColor('1a2f3f'),
          child: ListView.builder(
            padding: EdgeInsets.only(top: 3, bottom: 3),
            itemCount: cubit.homeModels!.data!.Products.length,
            itemBuilder: (context, index) => _buildProductsItems(
                cubit.homeModels!.data!.Products[index], context),
          ),
        ),
      ),
      fallback: (context) =>
          Center(child: CircularProgressIndicator()),
    );
  }

  /// Category Items
  Widget _buildProductsItems(ProductsModels productsModels, context) => Column(
        children: [
          if (productsModels.discount != 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.amber.withOpacity(0.1),
                    splashColor: Colors.amber.withOpacity(0.3),
                    onTap: ()
                    {
                      Navigator.of(context).push(
                        CustomPageRoute(
                          child : ProductsDetailsScreen(productsModels: productsModels),
                          direction: AxisDirection.right,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                child: Ink.image(
                                  image:
                                      NetworkImage('${productsModels.image}'),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 3,
                                ),
                                child: HomeCubit.get(context)
                                        .favorite[productsModels.id]!
                                    ? MaterialButton(
                                        minWidth: 50,
                                        elevation: 0,
                                        onPressed: () {
                                          HomeCubit.get(context)
                                              .putFavorite(productsModels.id!);
                                          HomeCubit.get(context).getFavorites();
                                        },
                                        color: HexColor('1a2f3f'),
                                        child: Icon(
                                          Icons.favorite_border_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        padding: EdgeInsets.all(10),
                                        shape: CircleBorder(
                                            side: BorderSide(
                                                width: 1,
                                                color: Colors.grey
                                                    .withOpacity(0.0))),
                                      )
                                    : MaterialButton(
                                        minWidth: 50,
                                        elevation: 0,
                                        onPressed: () {
                                          HomeCubit.get(context)
                                              .putFavorite(productsModels.id!);
                                          HomeCubit.get(context).getFavorites();
                                        },
                                        color: Colors.white,
                                        child: Icon(
                                          Icons.favorite_border_rounded,
                                          color: HexColor('1a2f3f')
                                              .withOpacity(0.8),
                                          size: 20,
                                        ),
                                        padding: EdgeInsets.all(10),
                                        shape: CircleBorder(
                                            side: BorderSide(
                                                width: 1,
                                                color: Colors.grey
                                                    .withOpacity(0.2))),
                                      ),
                              ),
                            ),
                            if (productsModels.discount != 0)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  ' offers ',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                        Text(
                          'More options available',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                        heightSizedBox(5),
                        Container(
                          height: 40,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: Text(
                                '${productsModels.name}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800]),
                              ),
                            ),
                          ),
                        ),
                        heightSizedBox(8),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              Icon(
                                Icons.star_half,
                                color: Colors.amber,
                                size: 18,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.grey[300],
                                size: 18,
                              ),
                              Text(' (63)',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 15)),
                            ],
                          ),
                        ),
                        heightSizedBox(8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${NumberFormat.currency(decimalDigits: 0, symbol: "").format(productsModels.price)}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 27,
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
                        ),
                        if (productsModels.discount != 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              children: [
                                Text(
                                  '${productsModels.old_price}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: '',
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey[500]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    ' LE',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: '',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[500]),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    ' ${productsModels.discount}% ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 10,),
                        HomeCubit.get(context).cart[productsModels.id]!
                            ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: OutlinedButton(
                          style: TextButton.styleFrom(
                              side:
                              BorderSide(width: 1, color: Colors.grey[300]!),
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () {

                              HomeCubit.get(context)
                                  .changeIndex(4);


                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  ShopIcon.checkmark_cicle,
                                  color: Colors.grey[300],
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'In cart',
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                          ),
                        ),
                            ) :
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: defaultButton(
                            function: ()
                            {
                              HomeCubit.get(context).putCart(productsModels.id!);
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
                                SizedBox(width: 5,),
                                Text(
                                  'Add to cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        // Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      );

}
