class GenreMoviesModel {
  final int id;
  final String name;

  GenreMoviesModel({required this.id, required this.name});

  factory GenreMoviesModel.fromJson(Map<String, dynamic> json) {
    return GenreMoviesModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
