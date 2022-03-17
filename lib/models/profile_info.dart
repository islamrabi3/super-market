class ProfileModel {
  bool? status;
  Map<String, dynamic>? data;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }
}
