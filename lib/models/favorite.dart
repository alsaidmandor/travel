class Favorite {
  String? distId;
  bool? isFav;
  int? index;

  Favorite({this.distId, this.isFav, this.index});

  Favorite.fromJson({required Map<String, dynamic> json}) {
    distId = json['distFavorite'];
    isFav = json['favorite'];
    index = json['index'];
  }
}
