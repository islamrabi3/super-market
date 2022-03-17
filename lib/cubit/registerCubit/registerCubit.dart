import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/registerCubit/registerStates.dart';
import 'package:shop_app/cubit/shop_app_cubit/appstates.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/shared/cache_helper/cache_helper.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/shared/dio/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

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

  RegisterModel? registerModel;
  Future<void> sendRegisterDataToApi({
    required String name,
    required String phone,
    required String password,
    required String email,
  }) async {
    emit(RegisterLoadingState());
    return await DioHelper.sendDataToApi(
            path: REGISTER,
            apiData: {
              'email': email,
              'name': name,
              'phone': phone,
              'password': password,
            },
            lang: 'ar')
        .then((value) {
      registerModel = RegisterModel.fromJson(value.data);

      print(value.toString());
      emit(RegisterSuccesState(registerModel: registerModel));
    }).catchError((error) {
      print(error);
      emit(RegisterErrorState());
    });
  }
}
