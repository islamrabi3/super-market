class WishModel {
  bool? status;
  String? message;
  WishData? data;

  WishModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? WishData.fromJson(json['data']) : null;
  }
}

class WishData {
  dynamic currentPage;
  List<WishIdAndProduct> dataList = [];

  WishData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    json['data'].forEach((element) {
      dataList.add(WishIdAndProduct.fromJson(element));
    });
  }
}

class WishIdAndProduct {
  dynamic id;
  ProductModelData? product;

  WishIdAndProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null
        ? ProductModelData.fromJson(json['product'])
        : null;
  }
}

class ProductModelData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorite;
  bool? inCart;

  ProductModelData.fromJson(Map<String, dynamic> json) {
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
