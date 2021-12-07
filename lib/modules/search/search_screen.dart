
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/models/search_models.dart';
import 'package:moon/modules/home/all_products_details_screen.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/icon/shop_icon_icons.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(

          appBar: _buildAppBar(context),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSearchListView(context,state),
            ],
          ),
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
    toolbarHeight: 60,
    elevation: 0.2,
    shadowColor: Colors.amber,

    titleSpacing: 0,
    leading: InkWell(
      onTap: ()
      {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back_outlined,
        color: Colors.white,
        size: 20,
      ),
    ),
    title: LimitedBox(maxHeight: 40, child: _buildTextField5(context)),
  );

  /// Searching in App Bar
  Widget _buildTextField5(context) => Padding(
    padding: const EdgeInsets.only(right: 10, left: 5),
    child: TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey[400],
        ),
        hintText: "What are you looking for ?",
        hintStyle: TextStyle(
          color:  Colors.grey[500],
          fontSize: 12,
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      controller: searchController,
      onFieldSubmitted: (value)
      {
        HomeCubit.get(context).putSearch(
          text: searchController.text,
        );
        HomeCubit.get(context).getHome();
      },
    ),
  );

  /// Searching List View
  Widget _buildSearchListView(context,state) {
    var cubit = HomeCubit.get(context);
    if(state is! getHomeLoadingState)
    {
      return ConditionalBuilder(
        condition: searchController.text != '' ,
        builder: (context) => ConditionalBuilder(
          condition: HomeCubit.get(context).searchModels!.data!.data.length > 0,
          builder: (context) => Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                  top: 3,
                  bottom: 0
              ),
              itemCount: cubit.searchModels!.data!.data.length,
              itemBuilder: (context, index) => _buildProductsItems(
                cubit.searchModels!.data!.data[index],
                context,
              ),
            ),
          ),

          fallback: (context) => Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: NetworkImage("https://stories.freepiklabs.com/api/vectors/empty/rafiki/render?color=1A2F3FFF&background=complete&hide="),
                    height: 200,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                  heightSizedBox(0),
                  Text(
                    'Sorry, It\'s not found!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: HexColor('1a2f3f'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        fallback: (context) => Expanded(
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: NetworkImage("https://image.freepik.com/free-vector/illustration-magnifying-glass-icon_53876-5613.jpg"),
                  height: 200,
                  width: 250,
                  fit: BoxFit.cover,
                ),
                heightSizedBox(0),
                Text(
                  'Search Now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: HexColor('1a2f3f'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

    } else {
      return Expanded(child: Center(child: CircularProgressIndicator(color: Colors.yellow,),));
    }
  }


  /// Category Items
  Widget _buildProductsItems(SearchProductsModels models,context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(
          // horizontal: 8,
            vertical: 3
        ),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
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
                    child : AllProductsDetailsScreen(
                      productsModels: HomeCubit.get(context).homeModels!.data!.Products
                      [HomeCubit.get(context).productsMap[models.id]],
                    ),
                    direction: AxisDirection.right,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Container(
                            height: 130,
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: Ink.image(
                              image: NetworkImage('${models.image}'),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3,),
                            child: HomeCubit.get(context)
                                .favorite[models.id]!
                                ? MaterialButton(
                              minWidth: 50,
                              elevation: 0,
                              onPressed: () {
                                HomeCubit.get(context)
                                    .putFavorite(models.id!);
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
                                      color: Colors.grey.withOpacity(0.0))),
                            )
                                : MaterialButton(
                              minWidth: 50,
                              elevation: 0,
                              onPressed: () {
                                HomeCubit.get(context)
                                    .putFavorite(models.id!);
                                HomeCubit.get(context).getFavorites();
                              },
                              color: Colors.white,
                              child: Icon(
                                Icons.favorite_border_rounded,
                                color: HexColor('1a2f3f').withOpacity(0.8),
                                size: 20,
                              ),
                              padding: EdgeInsets.all(10),
                              shape: CircleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      color: Colors.grey.withOpacity(0.2))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'More options available',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12
                      ),
                    ),
                    heightSizedBox(5),
                    Container(
                      height: 40,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            '${models.name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800]
                            ),
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
                          Text(
                              ' (63)',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15
                              )
                          ),
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
                            '${models.price}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 27,
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
                                  fontSize: 13,
                                  fontFamily: '',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800]
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    HomeCubit.get(context).cart[models.id]!
                        ? OutlinedButton(
                      style: TextButton.styleFrom(
                        side:
                        BorderSide(width: 1, color: Colors.grey[300]!),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
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
                    ) :
                    defaultButton(
                      function: ()
                      {
                        HomeCubit.get(context).putCart(models.id!);
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
                    SizedBox(height: 10,),
                    // Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          height: 5,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.grey[300],
          ),
        ),
      ),
    ],
  );


}
