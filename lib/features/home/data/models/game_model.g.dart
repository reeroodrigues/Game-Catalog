// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameModelAdapter extends TypeAdapter<GameModel> {
  @override
  final int typeId = 0;

  @override
  GameModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameModel(
      id: fields[0] as int,
      name: fields[1] as String,
      backgroundImage: fields[2] as String?,
      released: fields[3] as String?,
      rating: fields[4] as double?,
      descriptionRaw: fields[5] as String?,
      genres: (fields[6] as List?)?.cast<Genre>(),
      platforms: (fields[7] as List?)?.cast<PlatformEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, GameModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.backgroundImage)
      ..writeByte(3)
      ..write(obj.released)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.descriptionRaw)
      ..writeByte(6)
      ..write(obj.genres)
      ..writeByte(7)
      ..write(obj.platforms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GenreAdapter extends TypeAdapter<Genre> {
  @override
  final int typeId = 1;

  @override
  Genre read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Genre(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Genre obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlatformEntryAdapter extends TypeAdapter<PlatformEntry> {
  @override
  final int typeId = 2;

  @override
  PlatformEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlatformEntry(
      platform: fields[0] as PlatformInfo,
    );
  }

  @override
  void write(BinaryWriter writer, PlatformEntry obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.platform);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlatformEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlatformInfoAdapter extends TypeAdapter<PlatformInfo> {
  @override
  final int typeId = 3;

  @override
  PlatformInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlatformInfo(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlatformInfo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlatformInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameModel _$GameModelFromJson(Map<String, dynamic> json) => GameModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      backgroundImage: json['background_image'] as String?,
      released: json['released'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      descriptionRaw: json['description_raw'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      platforms: (json['platforms'] as List<dynamic>?)
          ?.map((e) => PlatformEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameModelToJson(GameModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'background_image': instance.backgroundImage,
      'released': instance.released,
      'rating': instance.rating,
      'description_raw': instance.descriptionRaw,
      'genres': instance.genres,
      'platforms': instance.platforms,
    };

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

PlatformEntry _$PlatformEntryFromJson(Map<String, dynamic> json) =>
    PlatformEntry(
      platform: PlatformInfo.fromJson(json['platform'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlatformEntryToJson(PlatformEntry instance) =>
    <String, dynamic>{
      'platform': instance.platform,
    };

PlatformInfo _$PlatformInfoFromJson(Map<String, dynamic> json) => PlatformInfo(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$PlatformInfoToJson(PlatformInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
