// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameReviewModel _$GameReviewModelFromJson(Map<String, dynamic> json) =>
    GameReviewModel(
      userId: json['userId'] as String,
      gameId: (json['gameId'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String?,
      status: json['status'] as String,
    );

Map<String, dynamic> _$GameReviewModelToJson(GameReviewModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'gameId': instance.gameId,
      'rating': instance.rating,
      'comment': instance.comment,
      'status': instance.status,
    };
