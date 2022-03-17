import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_app_cubit/appstates.dart';
import 'package:shop_app/cubit/shop_app_cubit/cubit.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        builder: (context, state) {
          var categoryModel = ShopAppCubit.get(context).categoryModel;
          return ListView.separated(
            itemBuilder: (context, index) => Container(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0),
                    ),
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      child: Image(
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: 200.0,
                          image: NetworkImage(
                              '${categoryModel!.data!.CategoryList[index].image}')),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${categoryModel.data!.CategoryList[index].name}',
                      style: TextStyle(color: Colors.black26, fontSize: 25.0),
                    ),
                  )),
                ],
              ),
            )),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey,
            ),
            itemCount: 4,
          );
        },
        listener: (context, state) {});
  }
}
