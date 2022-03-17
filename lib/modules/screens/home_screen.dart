import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_app_cubit/appstates.dart';
import 'package:shop_app/cubit/shop_app_cubit/cubit.dart';
import 'package:shop_app/models/cache_manager.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/screens/product_details_screen.dart';
import 'package:shop_app/shared/const.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(builder: (context, state) {
      var cubit = ShopAppCubit.get(context);

      return ConditionalBuilder(
        condition: cubit.homeModel != null,
        builder: (context) => buildHomeItems(cubit.homeModel!, context),
        fallback: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
    }, listener: (context, state) {
      if (state is ChangeFavoriteBtnState) {
        if (state.favotiteModel.status!) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: StadiumBorder(),
              backgroundColor: Colors.green,
              content: Text(
                '${state.favotiteModel.message}',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: StadiumBorder(),
              backgroundColor: Colors.red,
              content: Text(
                '${state.favotiteModel.message}',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      }
    });
  }

  Widget buildHomeItems(HomeModel model, BuildContext context) {
    var categoryModel = ShopAppCubit.get(context).categoryModel;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          buildBannerItems(context, model),
          SizedBox(
            height: 20.0,
          ),
          sectionHeader('Categories'),
          categorySection(categoryModel, context),
          sectionHeader('Product'),
          SizedBox(
            height: 2.0,
          ),
          buildProductItems(model, context)
        ],
      ),
    );
  }

  Widget categorySection(CategoryModel? categoryModel, BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0),
                ),
                child: Container(
                  height: 120.0,
                  width: 120.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Image(
                      //   height: 120.0,
                      //   width: 120.0,
                      //   fit: BoxFit.cover,
                      //   image: NetworkImage(
                      //       '${categoryModel!.data!.CategoryList[index].image}'),
                      // ),
                      CachedNetworkImage(
                        height: 120.0,
                        width: 120.0,
                        cacheManager: CustomCacheManager.instance,
                        fit: BoxFit.cover,
                        key: UniqueKey(),
                        imageUrl:
                            '${categoryModel!.data!.CategoryList[index].image}',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              // colorFilter: ColorFilter.mode(
                              //     Colors.red, BlendMode.colorBurn),
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),

                      Container(
                        width: double.infinity,
                        child: Text(
                          '${categoryModel.data!.CategoryList[index].name}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.black38,
                      )
                    ],
                  ),
                ),
              ));
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 10.0,
        ),
        itemCount:
            ShopAppCubit.get(context).categoryModel!.data!.CategoryList.length,
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.0),
              bottomLeft: Radius.circular(25.0),
            )),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            '$title',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildProductItems(HomeModel model, context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1 / 1.6,
      children: List.generate(
        model.data!.productList.length,
        (index) => InkWell(
          onTap: () => navigateTo(
              context,
              ProductDetailsScreen(
                image: model.data!.productList[index].image,
                title: model.data!.productList[index].name,
                price: model.data!.productList[index].price,
                oldPrice: model.data!.productList[index].oldPrice,
                disc: model.data!.productList[index].description,
                discount: model.data!.productList[index].discount,
              )),
          child: Stack(
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

                      CachedNetworkImage(
                        key: UniqueKey(),
                        cacheManager: CustomCacheManager.instance,
                        height: 200.0,
                        imageUrl: '${model.data!.productList[index].image}',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              // colorFilter: ColorFilter.mode(
                              //     Colors.red, BlendMode.colorBurn),
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Text(
                        '${model.data!.productList[index].name}',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Price :  ${model.data!.productList[index].price} LE'),
                              if (model.data!.productList[index].discount != 0)
                                Text(
                                  'OldPrice :  ${model.data!.productList[index].oldPrice} LE',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
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
                  backgroundColor: ShopAppCubit.get(context)
                          .favorites[model.data!.productList[index].id]!
                      ? Colors.indigoAccent
                      : Colors.grey,
                  child: IconButton(
                    onPressed: () {
                      ShopAppCubit.get(context)
                          .changeFavoriteBtn(model.data!.productList[index].id);
                      print(' ${model.data!.productList[index].id}');
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (model.data!.productList[index].discount != 0)
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.red,
                      child: Text(
                        'Discount',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBannerItems(BuildContext context, HomeModel model) {
    return CarouselSlider.builder(
      itemCount: ShopAppCubit.get(context).homeModel!.data!.bannerList.length,
      itemBuilder: (context, index, ind) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child:
              //  Image(
              //     fit: BoxFit.cover,
              //     image: NetworkImage('${model.data!.bannerList[index].image}')),
              CachedNetworkImage(
            key: UniqueKey(),
            height: 200.0,
            cacheManager: CustomCacheManager.instance,
            imageUrl: '${model.data!.bannerList[index].image}',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  // colorFilter: ColorFilter.mode(
                  //     Colors.red, BlendMode.colorBurn),
                ),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      },
      options: CarouselOptions(
        height: 150.0,
        autoPlay: true,
        enlargeCenterPage: true,
        scrollDirection: Axis.vertical,
        viewportFraction: 1.0,
        autoPlayAnimationDuration: Duration(seconds: 3),
        initialPage: 0,
        reverse: false,
      ),
    );
  }
}
