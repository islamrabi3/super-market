class LoginModel {
  bool? status;
  String? message;
  LoginData? data;
  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? LoginData.fromJson(json['data']) : json['data'];
  }
}

class LoginData {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? token;

  // LoginData({
  //   required this.email,
  //   required this.phone,
  //   required this.name,
  //   required this.password,
  // });

  LoginData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone': phone,
      'name': name,
      'token': token,
    };
  }
}
