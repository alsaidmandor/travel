class PopularDest {
  String? id;
  String? country;
  String? dest_place;
  String? description;
  String? image;
  bool? favorite;

  PopularDest({
    this.id,
    this.country,
    this.dest_place,
    this.description,
    this.image,
    this.favorite,
  });

  PopularDest.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    country = json['country'];
    dest_place = json['dest_place'];
    description = json['description'];
    image = json['image'];
    favorite = json['favorite'];
  }
}
