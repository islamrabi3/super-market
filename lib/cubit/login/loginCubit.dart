import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login/login_states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/cache_helper/cache_helper.dart';

import 'package:shop_app/shared/const.dart';
import 'package:shop_app/shared/dio/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  LoginModel? loginModel;
  void sendLoginDataToApi({
    required String password,
    required String email,
  }) {
    emit(LoginLoadingState());
    DioHelper.sendDataToApi(
            path: LOGIN,
            apiData: {
              'email': email,
              'password': password,
            },
            lang: 'ar')
        .then((value) {
      loginModel = LoginModel.fromJson(value.data);
      // token = value.data['token'];
      print(loginModel!.data!.token);
      token = loginModel!.data!.token;
      CacheHelper.prefs!.setString('token', token!);
      // here i put token inside shared pref and i will call it in main method in var called token without modifier.
      // CacheHelper.prefs!.setString('token', value.data['token']);

      print(value.toString());
      emit(LoginSuccesState(loginModel!));
    }).catchError((error) {
      print(error);
      emit(LoginErrorState());
    });
  }

  bool ispassword = true;
  IconData icon = Icons.remove_red_eye;

  void isPasswordChange() {
    ispassword = !ispassword;
    if (!ispassword) {
      icon = Icons.no_encryption_gmailerrorred;
    } else {
      icon = Icons.remove_red_eye;
    }

    emit(ChangePasswordState());
  }
}
