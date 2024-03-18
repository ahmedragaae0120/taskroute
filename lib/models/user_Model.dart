class userModel {
  String? id;
  String? email;
  String? name;
  userModel({required this.id, required this.name, required this.email});
  userModel.fromFirestore(Map<String, dynamic> data) {
    name = data["name"];
    email = data["email"];
    id = data["id"];
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (id != null) "id": id,
    };
  }
}
