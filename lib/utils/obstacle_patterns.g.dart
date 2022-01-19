// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obstacle_patterns.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Obstacle _$ObstacleFromJson(Map<String, dynamic> json) => Obstacle(
      posX: (json['posX'] as num).toDouble(),
      posY: (json['posY'] as num).toDouble(),
    );

Pattern _$PatternFromJson(Map<String, dynamic> json) => Pattern(
      json['name'] as String,
      (json['obstacles'] as List<dynamic>)
          .map((e) => Obstacle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

PatternList _$PatternListFromJson(Map<String, dynamic> json) => PatternList(
      (json['patterns'] as List<dynamic>)
          .map((e) => Pattern.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
