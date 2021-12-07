

import 'package:moon/models/add_order_models.dart';
import 'package:moon/models/addess_models.dart';
import 'package:moon/models/cancel_order_models.dart';
import 'package:moon/models/category_details_models.dart';
import 'package:moon/models/change_cart_models.dart';
import 'package:moon/models/category_models.dart';
import 'package:moon/models/change_favorite_models.dart';
import 'package:moon/models/contact_models.dart';
import 'package:moon/models/get_order_details_models.dart';
import 'package:moon/models/get_order_models.dart';
import 'package:moon/models/home_models.dart';
import 'package:moon/models/login_models.dart';
import 'package:moon/models/update_address.dart';
import 'package:moon/models/update_password.dart';
import 'package:moon/models/update_user_models.dart';


abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class changeNavBarState extends HomeStates {}

class changeFavoriteState extends HomeStates {}

class changeOpenState extends HomeStates {}

class changeDropDownState extends HomeStates {}


/// Home
class getHomeLoadingState extends HomeStates {}

class getHomeSuccessState extends HomeStates {
  final HomeModels homeModels;

  getHomeSuccessState(this.homeModels);
}

class getHomeErrorState extends HomeStates {
  final String error;

  getHomeErrorState(this.error);
}


/// Categories getCategoryLoadingState
class getCategoryLoadingState extends HomeStates {}

class getCategorySuccessState extends HomeStates {
  final CategoryModels categoryModels;

  getCategorySuccessState(this.categoryModels);
}

class getCategoryErrorState extends HomeStates {
  final String error;

  getCategoryErrorState(this.error);
}


/// Categories Details getCategoryLoadingState
class categoryItemDataLoadingState extends HomeStates {}

class categoryItemDataSuccessState extends HomeStates {
  final CategoryDetailsModel categoryDetailsModel;

  categoryItemDataSuccessState(this.categoryDetailsModel);
}

class categoryItemDataErrorState extends HomeStates {
  final String error;

  categoryItemDataErrorState(this.error);
}


/// add to Favorites
class changeFavoritesButtonSuccessState extends HomeStates {}

class changeFavoritesSuccessState extends HomeStates {
  final ChangeFavoritesModel changeFavoritesModel;

  changeFavoritesSuccessState(this.changeFavoritesModel);
}

class changeFavoritesButtonErrorState extends HomeStates {
  final String error;

  changeFavoritesButtonErrorState(this.error);
}


/// get  Favorites
class getFavoritesLoadingState extends HomeStates {}

class getFavoritesSuccessState extends HomeStates {}

class getFavoritesErrorState extends HomeStates {
  final String error;

  getFavoritesErrorState(this.error);
}


/// add to cart
class addCartLoadingState extends HomeStates {}

class addCartSuccessState extends HomeStates {
  final ChangeCartsModels changeCartsModels;

  addCartSuccessState(this.changeCartsModels);
}

class addCartErrorState extends HomeStates {
  final String error;

  addCartErrorState(this.error);
}


/// get  carts
class getCartsLoadingState extends HomeStates {}

class getCartsSuccessState extends HomeStates {}

class getCartsErrorState extends HomeStates {
  final String error;

  getCartsErrorState(this.error);
}



/// get  carts
class updateCartsLoadingState extends HomeStates {}

class updateCartsSuccessState extends HomeStates {}

class updateCartsErrorState extends HomeStates {
  final String error;

  updateCartsErrorState(this.error);
}




/// get  profile
class getProfileLoadingState extends HomeStates {}

class getProfileSuccessState extends HomeStates {}

class getProfileErrorState extends HomeStates {
  final String error;

  getProfileErrorState(this.error);
}


/// Update  profile
class UpdateProfileLoadingState extends HomeStates {}

class UpdateProfileSuccessState extends HomeStates {
  final UpdateUsersModels updateUsersModels;
  UpdateProfileSuccessState(this.updateUsersModels);
}

class UpdateProfileErrorState extends HomeStates {
  final String error;

  UpdateProfileErrorState(this.error);
}


/// Suffix Icon
class ChangeSuffixCurrentPasswordState extends HomeStates {}
class ChangeSuffixNewPasswordState extends HomeStates {}
class ChangeSuffixConfirmPasswordState extends HomeStates {}

/// Update  Password
class UpdatePasswordLoadingState extends HomeStates {}

class UpdatePasswordSuccessState extends HomeStates {
  final UpdatePasswordModels updatePasswordModels;
  UpdatePasswordSuccessState(this.updatePasswordModels);
}

class UpdatePasswordErrorState extends HomeStates {
  final String error;

  UpdatePasswordErrorState(this.error);
}

/// get  profile
class getAddressLoadingState extends HomeStates {}

class getAddressSuccessState extends HomeStates {
  final AddressModels addressModels;

  getAddressSuccessState(this.addressModels);
}

class getAddressErrorState extends HomeStates {
  final String error;

  getAddressErrorState(this.error);
}


/// Add  Address
class addAddressLoadingState extends HomeStates {}

class addAddressSuccessState extends HomeStates {
  final UpdateAddressModel updateAddressModels;
  addAddressSuccessState(this.updateAddressModels);
}

class addAddressErrorState extends HomeStates {
  final String error;

  addAddressErrorState(this.error);
}


/// Update  Address
class updateAddressLoadingState extends HomeStates {}

class updateAddressSuccessState extends HomeStates {
  final UpdateAddressModel updateAddressModels;
  updateAddressSuccessState(this.updateAddressModels);
}

class updateAddressErrorState extends HomeStates {
  final String error;

  updateAddressErrorState(this.error);
}


/// Remove  Address
class removeAddressLoadingState extends HomeStates {}

class removeAddressSuccessState extends HomeStates {
  final UpdateAddressModel updateAddressModels;
  removeAddressSuccessState(this.updateAddressModels);
}

class removeAddressErrorState extends HomeStates {
  final String error;

  removeAddressErrorState(this.error);
}


/// get Search
class putSearchLoadingState extends HomeStates {}

class putSearchSuccessState extends HomeStates {}

class putSearchErrorState extends HomeStates {
  final String error;

  putSearchErrorState(this.error);
}



/// add order
class addOrderLoadingState extends HomeStates {}

class addOrderSuccessState extends HomeStates {
  final AddOrdersModels addOrdersModels;

  addOrderSuccessState(this.addOrdersModels);
}

class addOrderErrorState extends HomeStates {
  final String error;

  addOrderErrorState(this.error);
}


/// get order
class getOrderLoadingState extends HomeStates {}

class getOrderSuccessState extends HomeStates {
  final GetOrderModels getOrderModels;

  getOrderSuccessState(this.getOrderModels);
}

class getOrderErrorState extends HomeStates {
  final String error;

  getOrderErrorState(this.error);
}


/// get order details
class getOrderDetailsLoadingState extends HomeStates {}

class getOrderDetailsSuccessState extends HomeStates {
  final GetOrderDetailsModels getOrderDetailsModels;

  getOrderDetailsSuccessState(this.getOrderDetailsModels);
}

class getOrderDetailsErrorState extends HomeStates {
  final String error;

  getOrderDetailsErrorState(this.error);
}



/// Cancel order details
class cancelOrderLoadingState extends HomeStates {}

class cancelOrderSuccessState extends HomeStates {
  final CancelOrderModel cancelOrderModel;

  cancelOrderSuccessState(this.cancelOrderModel);
}

class cancelOrderErrorState extends HomeStates {
  final String error;

  cancelOrderErrorState(this.error);
}


/// get Contact details
class getContactLoadingState extends HomeStates {}

class getContactSuccessState extends HomeStates {
  final ContactModels contactModels;

  getContactSuccessState(this.contactModels);
}

class getContactErrorState extends HomeStates {
  final String error;

  getContactErrorState(this.error);
}


/// get Contact details
class logoutLoadingState extends HomeStates {}

class logoutSuccessState extends HomeStates {
  final LoginModels loginModels;

  logoutSuccessState(this.loginModels);
}

class logoutErrorState extends HomeStates {
  final String error;

  logoutErrorState(this.error);
}


