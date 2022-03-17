import 'package:flutter/cupertino.dart';

class CategoryModel {
  bool? status;
  String? message;
  CategoryData? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CategoryData.fromJson(json['data']) : null;
  }
}

class CategoryData {
  List<CategoryDataItems> CategoryList = [];
  CategoryData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      CategoryList.add(CategoryDataItems.fromJson(element));
    });
  }
}

class CategoryDataItems {
  dynamic id;
  String? name;
  String? image;

  CategoryDataItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
