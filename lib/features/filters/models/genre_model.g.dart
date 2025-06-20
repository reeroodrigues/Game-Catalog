// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreModel _$GenreModelFromJson(Map<String, dynamic> json) => GenreModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$GenreModelToJson(GenreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

GenreListResponse _$GenreListResponseFromJson(Map<String, dynamic> json) =>
    GenreListResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenreListResponseToJson(GenreListResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
