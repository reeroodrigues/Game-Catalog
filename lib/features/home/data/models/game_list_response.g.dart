// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameListResponse _$GameListResponseFromJson(Map<String, dynamic> json) =>
    GameListResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => GameModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameListResponseToJson(GameListResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
