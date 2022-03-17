import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login/loginCubit.dart';
import 'package:shop_app/cubit/registerCubit/registerCubit.dart';
import 'package:shop_app/cubit/shop_app_cubit/cubit.dart';
import 'package:shop_app/modules/home_layout.dart';
import 'package:shop_app/modules/onboarding_screen.dart';
import 'package:shop_app/modules/registerScreen.dart';
import 'package:shop_app/shared/cache_helper/cache_helper.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/shared/dio/dio_helper.dart';
import 'package:shop_app/themes/colors.dart';

import 'cubit/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();

  bool boardDone = CacheHelper.prefs!.getBool('onboard') ?? false;
  token = CacheHelper.prefs!.getString('token');
  print(token);

  Widget widget = OnBoardingScreen();
  if (boardDone) {
    if (token != null) {
      widget = HomelayputScreeen();
    } else {
      widget = RegisterScreen();
    }
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget? startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopAppCubit()
            ..getHomeData()
            ..getCategoryData()
            ..getFavoriteData()
            ..getProfileData(),
        ),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Shop ',
        theme: ThemeData(
          // canvasColor: Colors.white24,
          primarySwatch: Colors.indigo,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 10.0,
            type: BottomNavigationBarType.fixed, // under test
            // backgroundColor: mainAppColor,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.indigoAccent,
            showSelectedLabels: true,
            showUnselectedLabels: true,
          ),
        ),
        home: startWidget,
      ),
    );
  }
}
