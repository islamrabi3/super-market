import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login/loginCubit.dart';
import 'package:shop_app/cubit/login/login_states.dart';
import 'package:shop_app/cubit/shop_app_cubit/appstates.dart';
import 'package:shop_app/cubit/shop_app_cubit/cubit.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/cache_helper/cache_helper.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/widgets/textformfield.dart';

class SettingScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        builder: (context, state) {
          var profileModel = ShopAppCubit.get(context).profileModel;
          emailController.text = profileModel!.data!['email'];
          nameController.text = profileModel.data!['name'];
          passwordController.text = profileModel.data!['phone'];
          return ConditionalBuilder(
            condition: profileModel != null,
            builder: (context) => SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    BuildTextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'E-Mail',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' Email must not be empty';
                        } else {
                          return null;
                        }
                      },
                      labelText: 'email',
                    ),
                    BuildTextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      hintText: 'Username',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' Username must not be empty';
                        } else {
                          return null;
                        }
                      },
                      labelText: 'Name',
                    ),
                    BuildTextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.phone,
                      hintText: 'E-Mail',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' phone must not be empty';
                        } else {
                          return null;
                        }
                      },
                      labelText: 'phone',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DefaultButton(
                      text: 'UPDATE ',
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DefaultButton(
                      text: 'LOG OUT ',
                      onPressed: () {
                        CacheHelper.prefs!.remove('token').then((value) {
                          context.read<ShopAppCubit>().logOut();
                          navigateAndRemove(context, LoginScreen());
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        listener: (context, state) {});
  }
}
