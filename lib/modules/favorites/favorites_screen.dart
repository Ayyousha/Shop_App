
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/models/favorite_models.dart';
import 'package:moon/modules/home/all_products_details_screen.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/icon/shop_icon_icons.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: _buildAppBar(context),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             if(HomeCubit.get(context).favoritesModels!.data!.data!.length > 0)
              _buildMyCartItems(context),
              _buildCartListView(context,state),
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
    title: Text(
      'My Favorites',
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

  /// My favorites Items count
  Widget _buildMyCartItems(context)=> Container(
    height: 40,
    width: double.infinity,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          bottom: 0
      ),
      child: Row(
        children: [
          Text(
            'My saved items',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10,),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey[200]
            ),
            child: Text('  ${HomeCubit.get(context).favoritesModels!.data!.data!.length}  '),
          ),
        ],
      ),
    ),
  );

  /// Cart List View
  Widget _buildCartListView(context,state) {
    var cubit = HomeCubit.get(context);
    return ConditionalBuilder(
      condition: (state is! getFavoritesLoadingState),
      builder: (context) => Expanded(
        child: ConditionalBuilder(
          condition: cubit.favoritesModels!.data!.data!.length > 0,
          builder: (context) {
            return RefreshIndicator(
              onRefresh: HomeCubit.get(context).onRefresh,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              color: HexColor('1a2f3f'),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0, bottom: 3),
                itemCount: cubit.favoritesModels!.data!.data!.length,
                itemBuilder: (context, index) => buildProductsItems(
                    cubit.favoritesModels!.data!.data![index].product!,context),
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
                  image: NetworkImage("https://stories.freepiklabs.com/api/vectors/empty/amico/render?color=1A2F3FFF&background=complete&hide="),
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                ),
                heightSizedBox(10),
                Text(
                  'Your favorites is empty!',
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
      ),
      fallback: (context) =>
          Expanded(child: Center(child: CircularProgressIndicator())),
    );
  }

  /// Products Items
  Widget buildProductsItems(Product model, context) => Column(
    children: [
      Container(
        height: 200,
        width: double.infinity,
        color: Colors.white,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.amber.withOpacity(0.1),
            splashColor: Colors.amber.withOpacity(0.3),
            onTap: ()
            {
              Navigator.push(context,
                  CustomPageRoute(
                      child: AllProductsDetailsScreen(
                        productsModels: HomeCubit.get(context).homeModels!.data!.Products
                        [HomeCubit.get(context).productsMap[model.id]],
                      ),
                    direction: AxisDirection.right,
                   ),
              );
            },
            child: Row(
              children: [
                SizedBox(width: 10,),
                Container(
                  height: double.infinity,
                  width: 100,
                  padding: EdgeInsets.all(10),
                  child: Ink.image(
                    image: NetworkImage('${model.image!}'),
                  ),
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
                              color: Colors.grey[800]
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      /// old price
                      if(model.discount != 0)
                        Row(
                          children: [
                            Text(
                              '${model.oldPrice!} LE',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                                fontWeight: FontWeight.w200,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Text(
                                ' Save ${model.oldPrice! - model.price!} LE (${model.discount!}%) ',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11
                                ),
                              ),
                            ),

                          ],
                        ),
                      SizedBox(height: 3,),
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
                                color: Colors.grey[800]
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              ' LE',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: '',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800]
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          /// add to cart
                          defaultButton(
                            height: 30,
                            width: 140,
                            function: ()
                            {
                              HomeCubit.get(context).putFavorite(model.id!);
                              HomeCubit.get(context).getFavorites();
                              HomeCubit.get(context).putCart(model.id!);
                              HomeCubit.get(context).getCarts();
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
                                  size: 15,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  'Move to cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          InkWell(
                            highlightColor: HexColor('1a2f3f').withOpacity(0.2),
                            splashColor: HexColor('1a2f3f').withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5),
                            onTap: ()
                            {
                              HomeCubit.get(context).putFavorite(model.id!);
                              HomeCubit.get(context).getFavorites();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    ShopIcon.trash,
                                    color: Colors.blue,
                                    size: 12,
                                  ),
                                  SizedBox(width: 3,),
                                  Text(
                                      'Remove',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox(width: 10,)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );

}
