import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/cache_manager.dart';

class ProductDetailsScreen extends StatelessWidget {
  String? image;
  String? title;
  dynamic price;
  dynamic oldPrice;
  String? disc;
  dynamic discount;

  ProductDetailsScreen(
      {this.image,
      this.title,
      this.price,
      this.oldPrice,
      this.disc,
      this.discount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: InteractiveViewer(
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          cacheManager: CustomCacheManager.instance,
                          height: 300.0,
                          imageUrl: '$image',
                          imageBuilder: (context, imageProvider) => Container(
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
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.black45,
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ))),
                    Positioned(
                      bottom: 15.0,
                      right: 15.0,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Add To Cart'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '$title',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Price : $price LE',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                if (discount != 0)
                  Text(
                    'OldPrice : $oldPrice  LE',
                    style: TextStyle(
                      color: Colors.grey[500],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'More Info About Product',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Text(
                      '$disc ',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
