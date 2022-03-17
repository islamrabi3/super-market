import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shop_app/cubit/shop_app_cubit/appstates.dart';
import 'package:shop_app/cubit/shop_app_cubit/cubit.dart';
import 'package:shop_app/modules/home_layout.dart';
import 'package:shop_app/modules/registerScreen.dart';
import 'package:shop_app/shared/cache_helper/cache_helper.dart';
import 'package:shop_app/shared/const.dart';

class OnBoardingScreen extends StatelessWidget {
  final introKey = GlobalKey<IntroductionScreenState>();
  // Widget widget;
  // OnBoardingScreen(this.widget);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        builder: (context, state) => IntroductionScreen(
              key: introKey,
              done: Text('Done'),
              showDoneButton: true,
              next: Text('Next'),
              showNextButton: true,
              onDone: () {
                navigateAndRemove(context, RegisterScreen());
                ShopAppCubit.get(context).changeBoardingStatus();
                if (ShopAppCubit.get(context).isBoardingScreenDone) {
                  CacheHelper.prefs!.setBool('onboard',
                      ShopAppCubit.get(context).isBoardingScreenDone);
                }
              },
              pages: pageViewList,
            ),
        listener: (context, state) {});
  }
}
