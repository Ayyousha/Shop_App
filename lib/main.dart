
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/layout/shop_layout.dart';
import 'package:moon/modules/cart/cart_screen.dart';
import 'package:moon/modules/login/cubit/cubit.dart';
import 'package:moon/modules/onboarding/onboarding_screen.dart';
import 'package:moon/modules/register/cubit/cubit.dart';
import 'package:moon/modules/starting/starting_screen.dart';
import 'package:moon/shared/components/constance.dart';
import 'package:moon/shared/cubit_observer/cubit_observer.dart';
import 'package:moon/shared/network/local/cache_helper.dart';
import 'package:moon/shared/network/remote/dio_helper.dart';
import 'package:moon/shared/style/themes.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

   var onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  if(onBoarding != null)
  {
    if(token != null){ widget = ShopLayoutScreen();}
    else { widget = StartingScreen();}
  }
  else
    {
      widget = OnBoardingScreen();
    }


  runApp( MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget? widget;

  MyApp({
    this.widget,
});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()
            ..getHome()
            ..getCategory()
            ..getFavorites()
            ..getCarts()
            ..getUser()
            ..getAddresses()
            ..getOrder()
            ..getOrderData()
            ..getContact()
            ,
          ),
          BlocProvider(create: (context) => LoginCubit(),),
          BlocProvider(create: (context) => RegisterCubit(),),
        ],
        child: BlocConsumer<HomeCubit,HomeStates>(
          listener: (context, state) {
          },
          builder: (context, state) {
            return MaterialApp(
              theme: LightTheme,
              debugShowCheckedModeBanner: false,
              home: OnBoardingScreen(),
            );
          },
        )
    );
  }
}








