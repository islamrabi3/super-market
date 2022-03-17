import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_app_cubit/appstates.dart';
import 'package:shop_app/cubit/shop_app_cubit/cubit.dart';
import 'package:shop_app/widgets/textformfield.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<ShopAppCubit>();
        var searchModel = cubit.searchModel;
        return Scaffold(
          appBar: AppBar(
            title: Text('What are you Looking for ?'),
          ),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                if (state is GetSearchLoadingState) LinearProgressIndicator(),
                BuildTextFormField(
                  onChanged: (value) {
                    context.read<ShopAppCubit>().searchMetod(value);
                  },
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  hintText: 'Search ',
                  labelText: 'Search your product here !!',
                ),
                ConditionalBuilder(
                  condition: searchModel != null,
                  builder: (context) => Expanded(
                    child: ListView.separated(
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
                                        height: 200.0,
                                        imageUrl:
                                            '${searchModel!.data!.data[index].image}',
                                        imageBuilder:
                                            (context, imageProvider) =>
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
                                      '${searchModel.data!.data[index].name}',
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
                                                'Price :  ${searchModel.data!.data[index].price} LE'),
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
                                                .favorites[
                                            searchModel.data!.data[index].id] !=
                                        null
                                    ? Colors.indigoAccent
                                    : Colors.grey,
                                child: IconButton(
                                  onPressed: () {
                                    ShopAppCubit.get(context).changeFavoriteBtn(
                                        searchModel.data!.data[index].id!);
                                    print(
                                        '${searchModel.data!.data[index].id}');
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
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
                      itemCount: searchModel!.data!.data.length,
                    ),
                  ),
                  fallback: (context) => Center(
                    child: SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
