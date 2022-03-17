import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shop_app/cubit/shop_app_cubit/appstates.dart';
import 'package:shop_app/cubit/shop_app_cubit/cubit.dart';

void navigateTo(context, Widget routeScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => routeScreen));
}

void navigateAndRemove(context, Widget routeScreen) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => routeScreen), (route) => false);
}

List<PageViewModel> pageViewList = [
  PageViewModel(
    decoration: PageDecoration(
      bodyAlignment: Alignment.topLeft,
      // fullScreen: true,
      imageAlignment: Alignment.center,
    ),
    body:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley',

    // titleWidget: Text('Shop APP'),
    titleWidget: Text(
      'Explore Many products',
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Colors.pink,
        fontWeight: FontWeight.bold,
      ),
    ),
    image: const Padding(
      padding: const EdgeInsets.all(15.0),
      child:
          Image(fit: BoxFit.cover, image: AssetImage('assets/shop-woman.png')),
    ),
  ),
  PageViewModel(
    decoration: const PageDecoration(
      bodyAlignment: Alignment.topLeft,
      // fullScreen: true,
      imageAlignment: Alignment.center,
    ),
    body:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley',

    // titleWidget: Text('Shop APP'),
    title: 'Choose and CheckOut  ',
    image: const Padding(
      padding: const EdgeInsets.all(15.0),
      child: Image(fit: BoxFit.cover, image: AssetImage('assets/onboard3.jpg')),
    ),
  ),
  PageViewModel(
    decoration: const PageDecoration(
      bodyAlignment: Alignment.topLeft,
      // fullScreen: true,
      imageAlignment: Alignment.center,
    ),
    body:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley',

    // titleWidget: Text('Shop APP'),
    title: 'Get it Delivered ',
    image: const Padding(
      padding: const EdgeInsets.all(15.0),
      child: Image(fit: BoxFit.cover, image: AssetImage('assets/onboard2.png')),
    ),
  ),
];

const List<BottomNavigationBarItem> bottomNavItem = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.category_outlined),
    label: 'Categories',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.favorite),
    label: 'Wishlist',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: 'Settings',
  ),
];

class DefaultButton extends StatelessWidget {
  String? text;
  Function()? onPressed;
  DefaultButton({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          '$text',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

const REGISTER = 'register';

String? token = '';

const LOGIN = 'login';

const HOME = 'home';
const FAVORITES = 'favorites';
const GET_FAVORITES = 'favorites';

const PROFILE = 'profile';
