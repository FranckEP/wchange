class UserModel {
  String name, password, email, pictureUrl;
  String? id;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.pictureUrl,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      pictureUrl: map['pictureUrl'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "pictureUrl": pictureUrl,
      "id": id,
    };
  }
}