import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login/loginCubit.dart';
import 'package:shop_app/cubit/login/login_states.dart';
import 'package:shop_app/modules/home_layout.dart';
import 'package:shop_app/modules/registerScreen.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/widgets/textformfield.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(builder: (context, state) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: const Image(
                          width: 200.0,
                          image: AssetImage(
                            'assets/onboard2.png',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'REGISTER NOW !',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink[300],
                          ),
                        ),
                      ),
                      BuildTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email Field',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email Must not be Empty';
                          }
                        },
                        labelText: 'Email ',
                        prefixIcon: Icons.email_outlined,
                      ),
                      BuildTextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'Password Field',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password Must not be Empty';
                          }
                        },
                        obscureText: LoginCubit.get(context).ispassword,
                        labelText: 'Password ',
                        prefixIcon: Icons.lock,
                        suffix: InkWell(
                          onTap: () {
                            LoginCubit.get(context).isPasswordChange();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Icon(LoginCubit.get(context).icon),
                          ),
                        ),
                      ),
                      state is LoginLoadingState
                          ? Center(child: CircularProgressIndicator())
                          : DefaultButton(
                              text: 'LOGIN',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).sendLoginDataToApi(
                                    password: passwordController.text,
                                    email: emailController.text,
                                  );
                                }
                              },
                            ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      DefaultButton(
                        text: 'REGISTER',
                        onPressed: () => navigateTo(
                          context,
                          RegisterScreen(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is LoginSuccesState) {
        if (state.loginModel.status!) {
          print('done');
          navigateAndRemove(context, HomelayputScreeen());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              shape: StadiumBorder(),
              backgroundColor: Colors.red,
              dismissDirection: DismissDirection.down,
              padding: EdgeInsets.all(20.0),
              content: Text(
                state.loginModel.message!,
                textAlign: TextAlign.center,
              )));
        }
      }
    });
  }
}
