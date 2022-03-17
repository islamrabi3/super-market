import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_app_cubit/appstates.dart';
import 'package:shop_app/cubit/shop_app_cubit/cubit.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);
          var wishModel = ShopAppCubit.get(context).wishModel;

          return ConditionalBuilder(
              condition: wishModel!.data!.dataList.isNotEmpty,
              builder: (context) => ListView.separated(
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  // Image(
                                  //     height: 200.0,
                                  //     image: NetworkImage(
                                  //         '${model.data!.productList[index].image}')),
                                  InteractiveViewer(
                                    child: CachedNetworkImage(
                                      height: 270.0,
                                      imageUrl:
                                          '${wishModel.data!.dataList[index].product!.image}',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.contain,
                                            // colorFilter: ColorFilter.mode(
                                            //     Colors.red, BlendMode.colorBurn),
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),

                                  Text(
                                    '${wishModel.data!.dataList[index].product!.name}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Price :  ${wishModel.data!.dataList[index].product!.price} LE'),
                                          if (wishModel.data!.dataList[index]
                                                  .product!.discount !=
                                              0)
                                            Text(
                                              'OldPrice :  ${wishModel.data!.dataList[index].product!.oldPrice} LE',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              backgroundColor:
                                  ShopAppCubit.get(context).favorites[wishModel
                                              .data!
                                              .dataList[index]
                                              .product!
                                              .id] !=
                                          null
                                      ? Colors.indigoAccent
                                      : Colors.grey,
                              child: IconButton(
                                onPressed: () {
                                  ShopAppCubit.get(context).changeFavoriteBtn(
                                      wishModel
                                          .data!.dataList[index].product!.id!);
                                  print(
                                      '${wishModel.data!.dataList[index].product!.id}');
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          if (wishModel
                                  .data!.dataList[index].product!.discount !=
                              0)
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.red,
                                  child: Text(
                                    'Discount',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    itemCount: wishModel.data!.dataList.length,
                  ),
              fallback: (context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You don`t have any Favorites ',
                          style: TextStyle(fontSize: 25.0, color: Colors.grey),
                        ),
                        Text(
                          ' you can add some !! ',
                          style: TextStyle(fontSize: 25.0, color: Colors.grey),
                        ),
                        Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ));
        },
        listener: (context, state) {});
  }
}
