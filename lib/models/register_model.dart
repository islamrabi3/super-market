class RegisterModel {
  bool? status;
  String? message;
  RegisterData? data;
  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? RegisterData.fromJson(json['data'])
        : json['data'];
  }
}

class RegisterData {
  String? name;
  String? phone;
  String? email;
  String? password;

  // RegisterData({
  //   required this.email,
  //   required this.phone,
  //   required this.name,
  //   required this.password,
  // });

  RegisterData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    password = json['password'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone': phone,
      'name': name,
      'password': password,
    };
  }
}
