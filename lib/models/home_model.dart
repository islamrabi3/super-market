class HomeModel {
  bool? status;
  String? message;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> bannerList = [];
  List<ProductModel> productList = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      bannerList.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      productList.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  dynamic id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorite;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
