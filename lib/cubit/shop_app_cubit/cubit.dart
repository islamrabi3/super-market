import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_app_cubit/appstates.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/favorite.model.dart';
import 'package:shop_app/models/favorites_item_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/profile_info.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/screens/category_screen.dart';
import 'package:shop_app/modules/screens/home_screen.dart';
import 'package:shop_app/modules/screens/settring_screen.dart';
import 'package:shop_app/modules/screens/wishlist_screen.dart';
import 'package:shop_app/shared/cache_helper/cache_helper.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/shared/dio/dio_helper.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(BuildContext context) => BlocProvider.of(context);

  bool isBoardingScreenDone = false;
  void changeBoardingStatus() {
    isBoardingScreenDone = true;
    emit(OnBoardingSuccess());
  }

  var currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    WishlistScreen(),
    SettingScreen(),
  ];
  void changeNavBarItems(int index) {
    currentIndex = index;

    emit(ChangeBottomNavItem());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopAppLoadingState());
    DioHelper.getDataFromApi(
      path: HOME,
      token: token,
      lang: 'en',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.data!.bannerList[0].id);
      homeModel!.data!.productList.forEach((e) {
        if (e.id == 64) {
          print('there is a problem');
        } else {
          favorites.addAll({
            e.id: e.inFavorite ?? true,
          });
        }
      });

      emit(ShopAppSuccesState());
    }).catchError((error) {
      print(error);
      emit(ShopAppErrorState());
    });
  }

// favorite model section
  FavotiteModel? favotiteModel;
  void changeFavoriteBtn(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavorite());
    DioHelper.sendDataToApi(
            path: FAVORITES,
            apiData: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      favotiteModel = FavotiteModel.fromJson(value.data);
      print(favotiteModel!.message);
      if (favotiteModel!.status!) {
        getFavoriteData();
      } else {
        favorites[productId] = !favorites[productId]!;
      }
      emit(ChangeFavoriteBtnState(favotiteModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(ChangeFavoriteErrorState());
    });
  }

  CategoryModel? categoryModel;
  getCategoryData() {
    DioHelper.getDataFromApi(path: 'categories', lang: 'en').then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopAppSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorState());
    });
  }

  WishModel? wishModel;

  void getFavoriteData() {
    DioHelper.getDataFromApi(
      path: GET_FAVORITES,
      token: token,
      lang: 'en',
    ).then((value) {
      wishModel = WishModel.fromJson(value.data);
      print(wishModel!.data!.dataList[0].id);
      emit(GetFavoritesSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoritesError());
    });
  }

  ProfileModel? profileModel;
  void getProfileData() {
    emit(GetProfileLoadingState());
    DioHelper.getDataFromApi(path: PROFILE, token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print(profileModel?.data!['name']);
      emit(GetProfileSuccessState());
    }).catchError((error) {
      emit(GetProfileErrorState());
    });
  }

  void logOut() {
    try {
      DioHelper.sendDataToApi(
        path: 'logout',
        apiData: {
          'fcm_token': token,
        },
        token: token,
      ).then((value) {
        print(value.data);
        emit(LogOutSuccessState());
      });
    } catch (e) {
      print(e.toString());
      emit(LogOutErrorState());
    }
  }

  SearchModel? searchModel;

  void searchMetod(String text) {
    emit(GetSearchLoadingState());
    DioHelper.sendDataToApi(
            path: 'products/search',
            apiData: {
              'text': text,
            },
            lang: 'en')
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(value.data.toString());
      emit(GetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchLoadingState());
    });
  }
}
