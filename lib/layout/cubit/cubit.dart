


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/models/add_order_models.dart';
import 'package:moon/models/addess_models.dart';
import 'package:moon/models/addess_models.dart';
import 'package:moon/models/cancel_order_models.dart';
import 'package:moon/models/cart_models.dart';
import 'package:moon/models/cart_update_models.dart';
import 'package:moon/models/category_details_models.dart';
import 'package:moon/models/change_cart_models.dart';
import 'package:moon/models/category_models.dart';
import 'package:moon/models/change_favorite_models.dart';
import 'package:moon/models/contact_models.dart';
import 'package:moon/models/favorite_models.dart';
import 'package:moon/models/get_order_details_models.dart';
import 'package:moon/models/get_order_models.dart';
import 'package:moon/models/home_models.dart';
import 'package:moon/models/login_models.dart';
import 'package:moon/models/search_models.dart';
import 'package:moon/models/update_address.dart';
import 'package:moon/models/update_password.dart';
import 'package:moon/models/update_user_models.dart';
import 'package:moon/models/user_models.dart';
import 'package:moon/modules/account/account_screen.dart';
import 'package:moon/modules/cart/cart_screen.dart';
import 'package:moon/modules/categories/categories_screen.dart';
import 'package:moon/modules/deals/deals_screen.dart';
import 'package:moon/modules/home/home_screen.dart';
import 'package:moon/shared/components/constance.dart';
import 'package:moon/shared/network/end_pointing.dart';
import 'package:moon/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screen =
  [
    HomeScreen(),
    CategoriesScreen(),
    DealsScreen(),
    AccountScreen(),
    CartScreen(),
  ];
  final searchPageController = PageController();

  void changeIndex(index) {
    currentIndex = index;
    emit(changeNavBarState());
  }


  bool isOpen = false;

  void open() {
    isOpen = !isOpen;
    emit(changeOpenState());
  }


  bool isPasswordOne = false;
  IconData suffixOne = Icons.visibility_outlined;

  void changeSuffixCurrentPassword() {
    isPasswordOne = !isPasswordOne;
    suffixOne =
    isPasswordOne ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeSuffixCurrentPasswordState());
  }


  bool isPasswordTwo = false;
  IconData suffixTwo = Icons.visibility_outlined;

  void changeSuffixNewPassword() {
    isPasswordTwo = !isPasswordTwo;
    suffixTwo =
    isPasswordTwo ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeSuffixNewPasswordState());
  }


  bool isPasswordThree = false;
  IconData suffixThree = Icons.visibility_outlined;

  void changeSuffixConfirmPassword() {
    isPasswordThree = !isPasswordThree;
    suffixThree =
    isPasswordThree ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeSuffixConfirmPasswordState());
  }

  /// DropdownButton
  int dropdownValue = 1;

  void changeDropDown(newValue) {
    dropdownValue = newValue;
    emit(changeDropDownState());
  }

  Future<void> onRefresh() async
  {
    getHome();
    getCategory();
    getFavorites();
    getCarts();
    getUser();
    getAddresses();
    getOrder();
    getOrderData();
    getContact();
    return Future.delayed(
      Duration(seconds: 3),
    );
  }


  Map <int, bool> favorite = {};
  Map <int, bool> cart = {};
  var productsMap = {};
  HomeModels? homeModels;

  void getHome() {
    emit(getHomeLoadingState());
    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModels = HomeModels.fromJson(value.data);
      var i = 0;
      homeModels!.data!.Products.forEach((element) {
        productsMap[element.id] = i++;
        favorite.addAll({
          element.id!: element.inFavorites!,
        });
        cart.addAll({
          element.id!: element.inCart!,
        });
      });
      emit(getHomeSuccessState(homeModels!));
    }).catchError((error) {
      emit(getHomeErrorState(error.toString()));
    });
  }


  CategoryModels? categoryModels;

  void getCategory() {
    emit(getCategoryLoadingState());
    DioHelper.getData(
      url: categories,
    ).then((value) {
      // print(value);
      categoryModels = CategoryModels.fromJson(value.data);
      emit(getCategorySuccessState(categoryModels!));
    }).catchError((error) {
      emit(getCategoryErrorState(error.toString()));
    });
  }

  CategoryDetailsModel? categoryDetailsModel;

  void getCategoryData({
    required int categoryId
  }) {
    emit(categoryItemDataLoadingState());

    DioHelper.getData(
      url: "categories/$categoryId",
      token: token,
    ).then((value) {
      categoryDetailsModel = CategoryDetailsModel.fromJson(value.data);
      emit(categoryItemDataSuccessState(categoryDetailsModel!));
    }).catchError((error) {
      emit(categoryItemDataErrorState(error));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void putFavorite(int product_id,) {
    favorite[product_id] = !favorite[product_id]!;
    emit(changeFavoritesButtonSuccessState());
    DioHelper.postData(
      url: favorites,
      token: token,
      data:
      {
        'product_id': product_id,
      },

    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel!.status!) {
        favorite[product_id] = !favorite[product_id]!;
      } else {
        getFavorites();
      }
      emit(changeFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      emit(changeFavoritesButtonErrorState(error.toString()));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }

  FavoritesModels? favoritesModels;

  void getFavorites() {
    emit(getFavoritesLoadingState());
    DioHelper.getData(
      url: favorites,
      token: token,
    ).then((value) {
      favoritesModels = FavoritesModels.fromJson(value.data);
      emit(getFavoritesSuccessState());
    }).catchError((error) {
      emit(getFavoritesErrorState(error.toString()));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }


  Map<int, int> productCartIds = {};
  var productsQuantity = {};
  Set cartItemsIds = {};
  var totalCarts = 0;

  void getQuantities() {
    totalCarts = 0;
    if (productsQuantity.isNotEmpty) {
      productsQuantity.forEach((key, value) {
        totalCarts += (value as int);
      });
    }
  }


  ChangeCartsModels? changeCartsModels;

  void putCart(int product_id,) {
    var productQuantity = productsQuantity[product_id];
    bool added = productQuantity == null;
    if (added) {
      productsQuantity[product_id] = 1;
    } else {
      cartItemsIds.remove(productCartIds[product_id]);
      productsQuantity.remove(product_id);
      productCartIds.remove(product_id);
    }
    cart[product_id] = !cart[product_id]!;
    emit(addCartLoadingState());
    DioHelper.postData(
      url: carts,
      token: token,
      data:
      {
        'product_id': product_id,
      },
    ).then((value) {
      changeCartsModels = ChangeCartsModels.fromJson(value.data);
      if (!changeCartsModels!.status!) {
        cart[product_id] = !cart[product_id]!;
      } else {
        getCarts();
      }
      emit(addCartSuccessState(changeCartsModels!));
    }).catchError((error) {
      emit(addCartErrorState(error.toString()));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }


  CartsModels? cartsModels;

  void getCarts() {
    emit(getCartsLoadingState());
    DioHelper.getData(
      url: carts,
      token: token,
    ).then((value) {
      // print(value);
      cartsModels = CartsModels.fromJson(value.data);
      cartsModels!.data!.cart_items.forEach((element) {
        productCartIds[element.product!.id!] = element.id!;
        productsQuantity[element.product!.id] = element.quantity;
      });
      cartItemsIds.addAll(productCartIds.values);
      emit(getCartsSuccessState());
      getQuantities();
    }).catchError((error) {
      emit(getCartsErrorState(error.toString()));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }

  CartsUpdateModels? cartsUpdateModels;

  void updateCart(int productId, {bool increment = true}) {
    emit(updateCartsLoadingState());
    var cart_id = productCartIds[productId];
    int quantity = productsQuantity[productId];
    if (increment && quantity >= 0)
      quantity++;
    else if (!increment && quantity > 1)
      quantity--;
    else if (!increment && quantity == 1) {
      quantity--;
      putCart(productId);
      return;
    }
    productsQuantity[productId] = quantity;
    DioHelper.putData(
        url: 'carts/$cart_id',
        token: token,
        query:
        {
          'quantity': quantity
        }
    ).then((value) {
      cartsUpdateModels = CartsUpdateModels.fromJson(value.data);
      emit(updateCartsSuccessState());
    }).catchError((error) {
      emit(updateCartsErrorState(error.toString()));
    });
  }


  UsersModels? usersModels;

  void getUser() {
    emit(getProfileLoadingState());
    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      usersModels = UsersModels.fromJson(value.data);
      emit(getProfileSuccessState());
    }).catchError((error) {
      emit(getProfileErrorState(error.toString()));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }


  UpdateUsersModels? updateUsersModels;

  void updateUser({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(
      url: updateProfile,
      token: token,
      query:
      {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      updateUsersModels = UpdateUsersModels.fromJson(value.data);
      emit(UpdateProfileSuccessState(updateUsersModels!));
    }).catchError((error) {
      emit(UpdateProfileErrorState(error.toString()));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }

  UpdatePasswordModels? updatePasswordModels;

  void updatePassword({
    required String CurrentPassword,
    required String NewPassword,
    required String ConfirmPassword,
  }) {
    emit(UpdatePasswordLoadingState());
    DioHelper.postData(
      url: changePassword,
      token: token,
      data:
      {
        'current_password': CurrentPassword,
        'new_password': CurrentPassword,
        'new_password': CurrentPassword,
      },
    ).then((value) {
      updatePasswordModels = UpdatePasswordModels.fromJson(value.data);
      emit(UpdatePasswordSuccessState(updatePasswordModels!));
    }).catchError((error) {
      emit(UpdatePasswordErrorState(error.toString()));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }


  AddressModels? addressModels;

  void getAddresses() {
    emit(getAddressLoadingState());
    DioHelper.getData
      (
        url: addresses,
        token: token
    ).then((value) {
      addressModels = AddressModels.fromJson(value.data);
      emit(getAddressSuccessState(addressModels!));
      if (addressModels!.data!.data.length != 0) {
        addressId = addressModels!.data!.data[0].id;
        isNewAddress = false;
      } else {
        addressId = 0;
        isNewAddress = true;
      }
    }).catchError((error) {
      emit(getAddressErrorState(error.toString()));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }


  int? addressId = 0;
  UpdateAddressModel? updateAddressModel;

  void addAddresses({
    required String name,
    required String city,
    required String region,
    required String details,
  }) {
    deleteAddress = false;

    emit(addAddressLoadingState());
    DioHelper.postData(
        url: addresses,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          "latitude": 30.0616863,
          "longitude": 31.3260088
        },
        token: token)
        .then((value) {
      updateAddressModel = UpdateAddressModel.fromJson(value.data);
      getAddresses();
      emit(addAddressSuccessState(updateAddressModel!));
    }).catchError((error) {
      emit(addAddressErrorState(error));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }


  bool isNewAddress = false;

  void updateAddresses({
    required String name,
    required String city,
    required String region,
    required String details
  }) {
    deleteAddress = false;
    emit(updateAddressLoadingState());
    DioHelper.putData(
        url: "addresses/${addressId}",
        query: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          "latitude": 30.0616863,
          "longitude": 31.3260088
        },
        token: token)
        .then((value) {
      updateAddressModel = UpdateAddressModel.fromJson(value.data);
      getAddresses();
      emit(updateAddressSuccessState(updateAddressModel!));
    }).catchError((error) {
      emit(updateAddressErrorState(error));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }

  bool deleteAddress = false;

  void deleteAddresses() {
    emit(removeAddressLoadingState());
    DioHelper.deleteData(
        url: "addresses/${addressId}",
        token: token
    )
        .then((value) {
      updateAddressModel = UpdateAddressModel.fromJson(value.data);
      deleteAddress = true;
      emit(removeAddressSuccessState(updateAddressModel!));
      getAddresses();
    }).catchError((error) {
      emit(removeAddressErrorState(error));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }


  SearchModels? searchModels;

  void putSearch({
    required String text,
  }) {
    emit(putSearchLoadingState());
    DioHelper.postData(
      url: search,
      token: token,
      data:
      {
        'text': text,
      },
    ).then((value) {
      searchModels = SearchModels.fromJson(value.data);
      emit(putSearchSuccessState());
    }).catchError((error) {
      emit(putSearchErrorState(error));
      print('Catching Error is (((( ${error.toString()} ))))');
    });
  }

  AddOrdersModels? addOrdersModels;

  void addOrder() {
    emit(addOrderLoadingState());
    DioHelper.postData(
        url: orders,
        token: token,
        data:
        {
          'address_id': addressId,
          'payment_method': 1,
          'use_points': false,
        }
    ).then((value) {
      addOrdersModels = AddOrdersModels.fromJson(value.data);
      print(value);
      if (addOrdersModels!.status!) {
        productCartIds.clear();
        productsQuantity.clear();
        cartItemsIds.clear();
        getOrder();
        emit(addOrderSuccessState(addOrdersModels!));
      } else {
        getCarts();
        getOrder();
      }
    }).catchError((error) {
      emit(addOrderErrorState(error.toString()));
    });
  }

  GetOrderModels? getOrderModels;

  void getOrder() {
    emit(getOrderLoadingState());
    DioHelper.getData(
      url: orders,
      token: token,
    ).then((value) {
      getOrderModels = GetOrderModels.fromJson(value.data);
      emit(getOrderSuccessState(getOrderModels!));
      ordersDetails.clear();
      ordersIds.clear();
      getOrderModels!.data!.data.forEach((element) {
        ordersIds.add(element.id!);
      });
    }).catchError((error) {
      emit(getOrderErrorState(error.toString()));
    });
  }

  List<int> ordersIds = [];
  GetOrderDetailsModels? getOrderDetailsModels;
  List<GetOrderDetailsModels> ordersDetails = [];

  void getOrderData()  {
    ordersDetails = [];
    emit(getOrderDetailsLoadingState());
    if (ordersIds.isNotEmpty) {
      for (var id in ordersIds) {
        DioHelper.getData(
          url: '$orders/$id',
          token: token,
        ).then((value)
        {
          getOrderDetailsModels = GetOrderDetailsModels.fromJson(value.data);
          ordersDetails.add(getOrderDetailsModels!);
          // print('*************************$getOrderDetailsModels');
          // print("/////////////////////////$ordersDetails");
          emit(getOrderDetailsSuccessState(getOrderDetailsModels!));
        }).catchError((error)
        {
          emit(getOrderDetailsErrorState(error.toString()));
          print("/////////////////////////${error.toString()}");
        });
      }
    }
  }

  CancelOrderModel? cancelOrderModel;
  void cancelOrder({required int id})
  {
    emit(cancelOrderLoadingState());
    DioHelper.getData(
        url: '$orders/$id/cancel',
      token: token,
    ).then((value)
    {
      cancelOrderModel = CancelOrderModel.fromJson(value.data);
      getOrder();
      emit(cancelOrderSuccessState(cancelOrderModel!));
    }).catchError((error)
    {
      emit(cancelOrderErrorState(error.toString()));
      print("/////////////////////////${error.toString()}");
    });
  }

  ContactModels? contactModels;
  void getContact()
  {
    emit(getContactLoadingState());
    DioHelper.getData(
        url: contacts,
        token: token,
    ).then((value)
    {
      contactModels = ContactModels.fromJson(value.data);
      emit(getContactSuccessState(contactModels!));
    }).catchError((error)
    {
      emit(getContactErrorState(error));
    });
  }


  LoginModels? loginModels;
  void logoutUser()
  {
    emit(logoutLoadingState());
    DioHelper.postData(
      url: "logout",
      token: token,
      data:
      {
        "fcm_token" : "SomeFcmToken",
      },
    ).then((value)
    {
      loginModels = LoginModels.fromJson(value.data);
      emit(logoutSuccessState(loginModels!));
    }).catchError((error)
    {
      emit(logoutErrorState(error));
    });
  }

}