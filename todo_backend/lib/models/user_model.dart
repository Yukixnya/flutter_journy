class UserModel {
  String username;
  String email;

  UserModel({required this.username, required this.email});

  Map<String, dynamic> userModelToMap() {
    return {'username': username, 'email': email};
  }

  UserModel.fromMap(Map<String, dynamic> map)
    : username = map['username'],
      email = map['email'];
}
