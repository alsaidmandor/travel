class Hotel {
  String? id;
  String? description;
  String? image;
  String? lat;
  String? lng;
  String? name;
  String? name_map;
  bool? favorite;

  Hotel({
    this.id,
    this.description,
    this.image,
    this.lat,
    this.lng,
    this.name,
    this.name_map,
    this.favorite,
  });

  Hotel.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    description = json['description'];
    image = json['image'];
    lat = json['lat'];
    lng = json['lng'];
    name = json['name'];
    name_map = json['name_map'];
    favorite = json['favorite'];
  }
}
