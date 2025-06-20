import 'package:json_annotation/json_annotation.dart';

part 'game_review_model.g.dart';

@JsonSerializable()
class GameReviewModel {
  final String userId;
  final int gameId;
  final double rating;
  final String? comment;
  final String status; // "quero jogar", "jogando", "já joguei"

  GameReviewModel({
    required this.userId,
    required this.gameId,
    required this.rating,
    this.comment,
    required this.status,
  });

  factory GameReviewModel.fromJson(Map<String, dynamic> json) =>
      _$GameReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameReviewModelToJson(this);
}
