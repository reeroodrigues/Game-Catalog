import 'package:json_annotation/json_annotation.dart';
import 'game_model.dart';

part 'game_list_response.g.dart';

@JsonSerializable()
class GameListResponse {
  final List<GameModel> results;

  GameListResponse({required this.results});

  factory GameListResponse.fromJson(Map<String, dynamic> json) =>
      _$GameListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GameListResponseToJson(this);
}
