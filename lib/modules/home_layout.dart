import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_app_cubit/appstates.dart';
import 'package:shop_app/cubit/shop_app_cubit/cubit.dart';
import 'package:shop_app/modules/screens/search_screen.dart';
import 'package:shop_app/shared/cache_helper/cache_helper.dart';
import 'package:shop_app/shared/const.dart';

class HomelayputScreeen extends StatelessWidget {
  const HomelayputScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search)),
              ],
              titleSpacing: 100.0,
              centerTitle: true,
              toolbarHeight: 100.0,
              toolbarOpacity: 1,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30.0))),
              title: Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(
                    'SUPER',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Mareket',
                    style: TextStyle(
                      fontSize: 10.0,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                  ),
                ],
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavItem,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeNavBarItems(index);
              },
              elevation: 12.0,
            ),
          );
        },
        listener: (context, state) {});
  }
}
