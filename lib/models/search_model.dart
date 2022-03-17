class SearchModel {
  bool? status;
  String? message;
  SeacrhData? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SeacrhData.fromJson(json['data']) : null;
  }
}

class SeacrhData {
  dynamic currentPage;
  List<SearchItems> data = [];

  SeacrhData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(SearchItems.fromJson(v));
      });
    }
  }
}

class SearchItems {
  dynamic id;
  dynamic price;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  SearchItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
