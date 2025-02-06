class UserData {
  final int id;
  final String name;
  final String username;
  final String email;
  UserData(this.id, this.name, this.username, this.email);

  UserData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        email = json['email'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
    };
  }
}