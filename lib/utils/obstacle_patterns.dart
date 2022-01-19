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
}
