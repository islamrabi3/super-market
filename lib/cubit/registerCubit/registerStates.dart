import 'package:shop_app/models/register_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccesState extends RegisterStates {
  RegisterModel? registerModel;

  RegisterSuccesState({this.registerModel});
}

class RegisterErrorState extends RegisterStates {}

class ChangePasswordState extends RegisterStates {}

class GetRegisterDataSuccessState extends RegisterStates {}
