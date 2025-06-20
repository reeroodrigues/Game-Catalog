import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'game_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class GameModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  @JsonKey(name: 'background_image')
  final String? backgroundImage;

  @HiveField(3)
  final String? released;

  @HiveField(4)
  final double? rating;

  @HiveField(5)
  @JsonKey(name: 'description_raw')
  final String? descriptionRaw;

  @HiveField(6)
  final List<Genre>? genres;

  @HiveField(7)
  final List<PlatformEntry>? platforms;

  GameModel({
    required this.id,
    required this.name,
    this.backgroundImage,
    this.released,
    this.rating,
    this.descriptionRaw,
    this.genres,
    this.platforms,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameModelToJson(this);
}

@HiveType(typeId: 1)
@JsonSerializable()
class Genre {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class PlatformEntry {
  @HiveField(0)
  final PlatformInfo platform;

  PlatformEntry({required this.platform});

  factory PlatformEntry.fromJson(Map<String, dynamic> json) =>
      _$PlatformEntryFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformEntryToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable()
class PlatformInfo {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  PlatformInfo({required this.id, required this.name});

  factory PlatformInfo.fromJson(Map<String, dynamic> json) =>
      _$PlatformInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformInfoToJson(this);
}
