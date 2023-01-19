class UserModel {
  String? name;
  String? id;
  String? photo;
  String? email;
  String? password;

  UserModel({
    this.name,
    this.id,
    this.photo,
    this.email,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    UserModel user = UserModel(
      name: json!['name'],
      id: json['id'],
      photo: json['photo'],
      email: json['email'],
      password: json['password'],
    );
    return user;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['id'] = id;
    data['photo'] = photo;
    data['email'] = email;
    data['password'] = password;

    return data;
  }
}
