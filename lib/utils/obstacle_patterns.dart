import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'obstacle_patterns.g.dart';

const patternsFileName = 'assets/config/patterns.json';

@JsonSerializable(createToJson: false)
class Obstacle {
  final double posX;
  final double posY;
  
  Obstacle get reversed => Obstacle(posX: posX, posY: 1 - posY);

  Obstacle({ required this.posX, required this.posY });

  factory Obstacle.fromJson(Map<String, dynamic> json) => _$ObstacleFromJson(json);
}

@JsonSerializable(createToJson: false)
class Pattern {
  final String name;
  final List<Obstacle> obstacles;
  @JsonKey(ignore: true)
  double? probability;

  List<Obstacle> get orderedObstacles => obstacles;

  List<Obstacle> get reversedObstacles => obstacles
    .map((obstacle) => obstacle.reversed)
    .toList();

  Pattern(this.name, this.obstacles);

  factory Pattern.fromJson(Map<String, dynamic> json) => _$PatternFromJson(json);
}

@JsonSerializable(createToJson: false)
class PatternList {
  final List<Pattern> patterns;

  PatternList(this.patterns) {
    resetProbabilities();
  }

  factory PatternList.fromJson(Map<String, dynamic> json) => _$PatternListFromJson(json);

  void resetProbabilities() {
    for (var p in patterns) {
      p.probability = (1 / patterns.length);
    }
  }

  /// Returns the most probable next pattern and updates the probabilities for all
  /// patterns in the list.
  Pattern getNextPattern() {
    // Find the most probable pattern
    patterns.sort((a, b) => a.probability!.compareTo(b.probability!));

    final nextPattern = patterns.removeAt(0);
    final redistributedProbability = (nextPattern.probability ?? 0) / patterns.length;

    // Redistribute the probability of next pattern between remaining patterns
    nextPattern.probability = 0;
    for (final p in patterns) {
      p.probability = (p.probability ?? 0) + redistributedProbability;
    }

    // Put next pattern back in the list with a zero probability
    patterns.add(nextPattern);
    
    return nextPattern;
  }
}

Future<PatternList> loadPatterns() async {
  final patternsJson = await rootBundle.loadString(patternsFileName);

  return PatternList.fromJson(jsonDecode(patternsJson));
}
