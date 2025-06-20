import 'package:json_annotation/json_annotation.dart';

part 'genre_model.g.dart';

@JsonSerializable()
class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);
  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}

@JsonSerializable()
class GenreListResponse {
  final List<GenreModel> results;

  GenreListResponse({required this.results});

  factory GenreListResponse.fromJson(Map<String, dynamic> json) =>
      _$GenreListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenreListResponseToJson(this);
}
