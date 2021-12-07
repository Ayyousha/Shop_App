import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/models/category_models.dart';
import 'package:moon/models/home_models.dart';
import 'package:moon/modules/categories/categories_items_screen.dart';
import 'package:moon/modules/home/all_products_screen.dart';
import 'package:moon/modules/home/products_details_screen.dart';
import 'package:moon/modules/search/search_screen.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/components/constance.dart';
import 'package:moon/shared/icon/shop_icon_icons.dart';

class HomeScreen extends StatelessWidget {

  List<String> bannerImages = [
    'https://image.freepik.com/free-vector/new-year-sale-discount-banner-template-promotion_7087-1017.jpg',
    'https://image.freepik.com/free-vector/mega-sale-offers-banner-template_1017-31299.jpg',
    'https://image.freepik.com/free-vector/realistic-3d-sale-background_52683-62689.jpg',
    'https://image.freepik.com/free-vector/gradient-sale-background_23-2148934477.jpg',
    'https://image.freepik.com/free-vector/crazy-discount-promotion-super-sale-banner-template-vector-graphi_7087-1927.jpg',
    'https://image.freepik.com/free-vector/mega-discount-promotion-super-sale-banner-template-vector-illustration_7087-1944.jpg',
    'https://image.freepik.com/free-vector/big-sale-discount-promotion-banner_7087-1937.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
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
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: buildAppBar(context),
          body: ConditionalBuilder(
            condition: cubit.homeModels != null && cubit.categoryModels != null,
            builder: (context) =>
                _buildBody(cubit.homeModels!, cubit.categoryModels!, context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }


  /// body
  Widget _buildBody(
      HomeModels homeModels, CategoryModels categoryModels, context) {
    return RefreshIndicator(
      onRefresh: HomeCubit.get(context).onRefresh,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      color: HexColor('1a2f3f'),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanners(homeModels, context),
            heightSizedBox(10),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Column(
                children: [
                  _buildCategoryDetails(context),
                  heightSizedBox(13),
                  _buildCategoryList(categoryModels),
                  heightSizedBox(10),
                  _buildProductsDetails(context),
                  heightSizedBox(8),
                  _buildProductsList(homeModels, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Banners
  Widget _buildBanners(HomeModels homeModels, context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          CustomPageRoute(
            child: AllProductsScreen(),
            direction: AxisDirection.right,
          ),
        );
      },
      child: CarouselSlider(
        items: bannerImages
            .map(
              (e) => Image(
                image: NetworkImage('${e}'),
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 180,
          initialPage: 0,
          autoPlay: true,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          viewportFraction: 1.0,
        ),
      ),
    );
  }

  /// Category Text & Button
  Widget _buildCategoryDetails(context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Text(
              'Shop by Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            Spacer(),
            LimitedBox(
              maxHeight: 30,
              child: OutlinedButton(
                style: TextButton.styleFrom(
                  backgroundColor: HexColor('1a2f3f').withOpacity(0.9),
                  side: BorderSide(width: 1, color: HexColor('1a2f3f')),
                ),
                onPressed: () {
                  HomeCubit.get(context).changeIndex(1);
                },
                child: Text(
                  'VIEW ALL',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );

  /// Categories
  Widget _buildCategoryList(CategoryModels categoryModels) => Container(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              buildCategoryItems(categoryModels.data!.data[index],context),
          separatorBuilder: (context, index) => SizedBox(
            width: 0,
          ),
          itemCount: categoryModels.data!.data.length,
        ),
      );

  /// Category Items
  Widget buildCategoryItems(CategoryData categoryData,context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: ()
          {
            HomeCubit.get(context).getCategoryData(categoryId: categoryData.id!);
            Navigator.of(context).push(
              CustomPageRoute(
                child : CategoriesItemsScreen(name: categoryData.name!,),
                direction: AxisDirection.right,
              ),
            );
          },
          highlightColor: Colors.amber.withOpacity(0.1),
          splashColor: Colors.amber.withOpacity(0.3),
          borderRadius: BorderRadius.circular(0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 65,
                    width: 110,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: HexColor('1a2f3f').withOpacity(0.8),
                    ),
                  ),
                  Image(
                    image: NetworkImage(categoryData.image!),
                    fit: BoxFit.fill,
                    height: 60.0,
                    width: 105.0,
                  ),
                ],
              ),
              heightSizedBox(3),
              LimitedBox(
                maxWidth: 70,
                child: Text(
                  categoryData.name!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'pretty1',
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  /// Products Text & Button
  Widget _buildProductsDetails(context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Text(
              'Products',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            Spacer(),
            LimitedBox(
              maxHeight: 30,
              child: OutlinedButton(
                style: TextButton.styleFrom(
                  backgroundColor: HexColor('1a2f3f').withOpacity(0.9),
                  side: BorderSide(width: 1, color: HexColor('1a2f3f')),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    CustomPageRoute(
                      child: AllProductsScreen(),
                      direction: AxisDirection.right,
                    ),
                  );
                },
                child: Text(
                  'VIEW ALL',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );

  /// Products
  Widget _buildProductsList(HomeModels homeModels, context) => Container(
        color: Colors.grey[200],
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 0.8),
          crossAxisSpacing: 0.8,
          mainAxisSpacing: 0.8,
          childAspectRatio: 1 / 2.1,
          children: List.generate(
            homeModels.data!.Products.length,
            (index) =>
                buildProductsItems(homeModels.data!.Products[index], context),
          ),
        ),
      );

  /// Products Items
  Widget buildProductsItems(ProductsModels productsModels, context) =>
      Container(
        color: Colors.white,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.amber.withOpacity(0.1),
            splashColor: Colors.amber.withOpacity(0.3),
            onTap: () {
              Navigator.of(context).push(
                CustomPageRoute(
                  child: ProductsDetailsScreen(
                    productsModels: productsModels,
                  ),
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        child: Ink.image(
                          image: NetworkImage('${productsModels.image}'),
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
                                        color: Colors.grey.withOpacity(0.0))),
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
                    if (productsModels.discount != 0)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          ' Sale ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ],
                ),
                Text(
                  'More options available',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                heightSizedBox(5),
                Container(
                  height: 40,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
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
                          style: TextStyle(color: Colors.blue, fontSize: 15)),
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
                              fontSize: 11,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Text(
                            ' Save ${productsModels.old_price - productsModels.price} LE (${productsModels.discount}%) ',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                Spacer(),
                HomeCubit.get(context).cart[productsModels.id]!
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
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
                            // HomeCubit.get(context).putCart(productsModels.id!);
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
                      )
                    : OutlinedButton(
                        style: TextButton.styleFrom(
                          side: BorderSide(width: 1, color: HexColor('1a2f3f')),
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () {
                          HomeCubit.get(context).putCart(productsModels.id!);
                          HomeCubit.get(context).getCarts();
                        },
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                            color: HexColor('1a2f3f'),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      );


}
