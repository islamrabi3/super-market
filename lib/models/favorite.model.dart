class FavotiteModel {
  bool? status;
  String? message;

  FavotiteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
