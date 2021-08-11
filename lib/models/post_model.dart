class PostModel {
  String? country;
  String? uId;
  String? image;
  String? place;
  String? aboutImage;

  PostModel({
    this.country,
    this.uId,
    this.image,
    this.place,
    this.aboutImage,
  });

  PostModel.fromJson({required Map<String, dynamic> json}) {
    country = json['country'];
    uId = json['uId'];
    image = json['image'];
    place = json['place'];
    aboutImage = json['aboutImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'uId': uId,
      'image': image,
      'place': place,
      'aboutImage': aboutImage,
    };
  }
}
