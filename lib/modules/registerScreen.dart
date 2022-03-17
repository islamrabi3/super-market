import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/registerCubit/registerCubit.dart';
import 'package:shop_app/cubit/registerCubit/registerStates.dart';
import 'package:shop_app/cubit/shop_app_cubit/appstates.dart';

import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/widgets/textformfield.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameConroller = TextEditingController();
  var phoneConroller = TextEditingController();
  var emailConroller = TextEditingController();
  var passwordConroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
        builder: (context, state) {
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
                        controller: nameConroller,
                        keyboardType: TextInputType.text,
                        hintText: 'Name Field',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name Must not be Empty';
                          }
                        },
                        labelText: 'Name ',
                        prefixIcon: Icons.person,
                      ),
                      BuildTextFormField(
                        controller: phoneConroller,
                        keyboardType: TextInputType.phone,
                        hintText: 'Phone Field',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Must not be Empty';
                          }
                        },
                        labelText: 'Phone ',
                        prefixIcon: Icons.phone,
                      ),
                      BuildTextFormField(
                        controller: emailConroller,
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
                        controller: passwordConroller,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'Password Field',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password Must not be Empty';
                          }
                        },
                        obscureText: RegisterCubit.get(context).ispassword,
                        labelText: 'Password ',
                        prefixIcon: Icons.lock,
                        suffix: InkWell(
                          onTap: () {
                            RegisterCubit.get(context).isPasswordChange();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Icon(RegisterCubit.get(context).icon),
                          ),
                        ),
                      ),
                      state is RegisterLoadingState
                          ? Center(child: CircularProgressIndicator())
                          : DefaultButton(
                              text: 'REGISTER',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context)
                                      .sendRegisterDataToApi(
                                        name: nameConroller.text,
                                        phone: phoneConroller.text,
                                        password: passwordConroller.text,
                                        email: emailConroller.text,
                                      )
                                      .then((value) {});
                                }
                              },
                            ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      DefaultButton(
                        text: 'LOGIN',
                        onPressed: () => navigateTo(
                          context,
                          LoginScreen(),
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
      if (state is RegisterSuccesState) {
        if (state.registerModel!.status!) {
          print('done');
          navigateTo(context, LoginScreen());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              shape: StadiumBorder(),
              backgroundColor: Colors.red,
              dismissDirection: DismissDirection.down,
              padding: EdgeInsets.all(20.0),
              content: Text(
                state.registerModel!.message!,
                textAlign: TextAlign.center,
              )));
        }
      }
    });
  }
}
