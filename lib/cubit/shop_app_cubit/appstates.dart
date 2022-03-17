import 'package:shop_app/models/favorite.model.dart';

abstract class ShopAppStates {}

class ShopAppInitialState extends ShopAppStates {}

class ShopAppLoadingState extends ShopAppStates {}

class ShopAppSuccesState extends ShopAppStates {}

class ShopAppErrorState extends ShopAppStates {}

class OnBoardingSuccess extends ShopAppStates {}

class ChangeBottomNavItem extends ShopAppStates {}

class ChangeFavoriteBtnState extends ShopAppStates {
  final FavotiteModel favotiteModel;
  ChangeFavoriteBtnState(this.favotiteModel);
}

class ChangeFavoriteErrorState extends ShopAppStates {}

class ChangeFavorite extends ShopAppStates {}

class GetFavoritesSuccess extends ShopAppStates {}

class GetFavoritesError extends ShopAppStates {}

class LogOutSuccessState extends ShopAppStates {}

class LogOutErrorState extends ShopAppStates {}

class GetProfileSuccessState extends ShopAppStates {}

class GetProfileLoadingState extends ShopAppStates {}

class GetProfileErrorState extends ShopAppStates {}

class GetSearchSuccessState extends ShopAppStates {}

class GetSearchLoadingState extends ShopAppStates {}

class GetSearchErrorState extends ShopAppStates {}
