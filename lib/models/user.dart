class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? bio;
  String? image;
  String? cover;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.bio,
    this.image,
    this.cover,
  });

  UserModel.fromJson({required Map<String, dynamic>? json}) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'bio': bio,
      'image': image,
      'cover': cover,
    };
  }
}
