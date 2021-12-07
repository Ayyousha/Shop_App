
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/models/cart_models.dart';
import 'package:moon/models/home_models.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/icon/shop_icon_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class CartDetailsScreen extends StatelessWidget {
  final Products productsModels;
  var _pageController = PageController();
  var description = [];
  var descriptionDivide = [];
  final dataKey = new GlobalKey();
  // bool isOpen = false;
  CartDetailsScreen({Key? key,
    required this.productsModels,

  }) : super(key: key);

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
        // var cubit = HomeCubit.get(context);
        description = productsModels.description!.split("\r\n");
        descriptionDivide.clear();
        divideDescription();
        var length = descriptionDivide.length;
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: _buildAppBar(context),
          body: _buildUserBody(context),
        );
      },
    );
  }

  /// App Bar
  PreferredSizeWidget _buildAppBar(context) => AppBar(
    backgroundColor: HexColor('1a2f3f'),

    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: HexColor('1a2f3f'),
    ),
    leading: IconButton(
      onPressed: ()
      {
        Navigator.pop(context);
      },
      splashRadius: 23,
      icon: Icon(
        ShopIcon.arrow_left,
        color: Colors.white,
      ),
    ),
    actions: [

      IconButton(
        splashRadius: 23,
        onPressed: (){},
        icon: Icon(
          ShopIcon.exit_up,
          color: Colors.white,
        ),
      ),
      widthSizedBox(8),
    ],
  );

  /// Body
  Widget _buildUserBody(context) => Column(
    children: [
      _buildProductContainer(context),
      _buildAddCartBar(context),
    ],
  );

  /// Product Container
  Widget _buildProductContainer(context) => Expanded(
    child: RefreshIndicator(
      onRefresh: HomeCubit.get(context).onRefresh,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      color: HexColor('1a2f3f'),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// Name && Mark Name
            _buildMarkNameAndName(),

            /// photo && favorites && smooth
            _buildPhotoAndFavoritesAndSmooth(context),

            /// Discount && old price
            if(productsModels.discount != 0)
              _buildDiscountAndOldPrice(),

            /// price
            _buildPriceAndInstallmentAndDeliveryDetails(),

            /// add to cart button
            _buildAddButton(context),

            /// Specification
            _buildSpecification(context),
          ],
        ),
      ),
    ),
  );

  /// Name && Mark Name
  Widget _buildMarkNameAndName() => Column(
    children: [
      Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSizedBox(10),
              Text(
                '${productsModels.markName}',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: HexColor('1a2f3f'),
                ),
              ),


            ],
          ),
        ),
      ),
      /// name
      Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 3
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSizedBox(5),
              Text(
                '${productsModels.name}',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),
              ),
              heightSizedBox(5),
            ],
          ),
        ),
      ),
    ],
  );

  /// photo && favorites && smooth
  Widget _buildPhotoAndFavoritesAndSmooth(context) => Column(
    children: [
      Container(
        width: double.infinity,
        height: 200,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Image(
                        image: NetworkImage('${productsModels.images[index]}'),
                      );
                    },
                    itemCount: productsModels.images.length,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
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
                ],
              ),
            ),

          ],
        ),
      ),
      /// smooth
      Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            heightSizedBox(0),
            SmoothPageIndicator(
              controller: _pageController,
              count: productsModels.images.length,
              effect: ScrollingDotsEffect(
                spacing: 10,
                dotHeight: 10,
                dotWidth: 5,
                activeDotColor: HexColor('1a2f3f'),
                dotColor: Colors.grey[300]!,
              ),
            ),

          ],
        ),
      ),
    ],
  );

  /// Discount && old price
  Widget _buildDiscountAndOldPrice() => Container(
    width: double.infinity,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 4,
          bottom: 0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightSizedBox(5),
          Row(
            children: [
              Text(
                '${productsModels.old_price} LE',
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
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Text(
                  ' Save ${productsModels.old_price - productsModels.price} LE (${productsModels.discount}%) ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11
                  ),
                ),
              ),
            ],
          ),
          heightSizedBox(5),
        ],
      ),
    ),
  );

  /// Price && installment && delivery details
  Widget _buildPriceAndInstallmentAndDeliveryDetails() => Column(
    children: [
      Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 0,
              bottom: 5
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${NumberFormat.currency(decimalDigits: 0, symbol: "").format(productsModels.price)}',
                    // '${productsModels.price}',
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


            ],
          ),
        ),
      ),
      /// installment
      Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 0,
              bottom: 0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                ),
                height: 40,

                child: Center(
                  child: Text(
                    'No installment plans available for this product',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
      /// delivery
      Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
              bottom: 0
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.green,
                    ),
                    heightSizedBox(4),
                    Text(
                      'Pay on delivery',
                      style: TextStyle(
                          fontFamily: '',
                          fontWeight: FontWeight.w400,
                          fontSize: 13
                      ),
                    ),
                    heightSizedBox(2),
                    Text(
                      'Cash or card',
                      style: TextStyle(
                          fontFamily: '',
                          color: Colors.grey,
                          fontSize: 12
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 0.5,
                color: Colors.grey,
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.refresh,
                      color: Colors.green,
                    ),
                    heightSizedBox(4),
                    Text(
                      'Return for free',
                      style: TextStyle(
                          fontFamily: '',
                          fontWeight: FontWeight.w400,
                          fontSize: 13
                      ),
                    ),
                    heightSizedBox(2),
                    Text(
                      'Up to 30 days',
                      style: TextStyle(
                          fontFamily: '',
                          color: Colors.grey,
                          fontSize: 12
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    ],
  );

  /// add to cart button
  Widget _buildAddButton(context) => Container(
    width: double.infinity,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 0
      ),
      child: Column(
        children: [
          heightSizedBox(5),
          HomeCubit.get(context).cart[productsModels.id]!
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
                  .changeIndex(4) ;
              HomeCubit.get(context).putCart(productsModels.id!);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  ShopIcon.checkmark_cicle,
                  color: Colors.grey[300],
                  size: 15,
                ),
                widthSizedBox(10),
                Text(
                  'In cart',
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          )
              :
          defaultButton(
            function: (){},
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
                  'Add to cart',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          heightSizedBox(5),
        ],
      ),
    ),
  );

  /// Specification
  Widget _buildSpecification(context) {
    var length = descriptionDivide.length;
    return Column(
      children: [
        InkWell(
          onTap: ()
          {
            HomeCubit.get(context).open();
          },
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 7
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSizedBox(5),
                  Row(
                    children: [
                      Text(
                        'Specifications',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:HexColor('1a2f3f'),
                        ),
                      ),
                      Spacer(),
                      HomeCubit.get(context).isOpen ? Icon(
                        ShopIcon.arrow_up_circle,
                        color: HexColor('1a2f3f'),
                        size: 20,
                      ) : Icon(
                        ShopIcon.arrow_down_circle,
                        color: HexColor('1a2f3f'),
                        size: 20,
                      ),
                    ],
                  ),
                  heightSizedBox(10),
                ],
              ),
            ),
          ),
        ),
        MyDivider(),
        if(HomeCubit.get(context).isOpen)
          if (descriptionDivide.length > 3)
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 7
                ),
                child: Container(
                  height: (length * 1030) / 25,
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        _buildSeparatedDetails(descriptionDivide[index], index),
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: Container(
                        color: Colors.grey,
                        width: double.infinity,
                        height: 0.2,
                      ),
                    ),
                    itemCount: length > 30 ? 30 : length,
                  ),
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 7
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                          child: Text(
                            '${productsModels.description}',
                            style: TextStyle(
                              fontSize: 14,

                            ),
                          ),
                        ),
                      ),
                    ),
                    heightSizedBox(5),
                  ],
                ),
              ),
            ),
      ],
    );
  }

  /// Add Cart Bar
  Widget _buildAddCartBar(context) => Container(
    width: double.infinity,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0
      ),
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
                      '${NumberFormat.currency(decimalDigits: 0, symbol: "").format(productsModels.price)}',
                      // '${productsModels.price}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 23,
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
                Spacer(),
                HomeCubit.get(context).cart[productsModels.id]!
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
                        .changeIndex(4) ;
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
                      widthSizedBox(10),
                      Text(
                        'In cart',
                        style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                )
                    :
                defaultButton(
                  width: 130,
                  function: (){},
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
                        'Add to cart',
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

  /// Separated Details
  Widget _buildSeparatedDetails(string, index) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            string.split(":")[0],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: HexColor('1a2f3f').withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Container(
              width: 200,
              child: Text(
                string.split(":")[1],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Divide Description
  void divideDescription() {
    for (String string in description) {
      if (string.contains(":")) descriptionDivide.add(string);
      if (descriptionDivide.length == 25) break;
    }
  }

}


