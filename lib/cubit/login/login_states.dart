import 'package:shop_app/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccesState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccesState(this.loginModel);
}

class LoginErrorState extends LoginStates {}

class ChangePasswordState extends LoginStates {}
