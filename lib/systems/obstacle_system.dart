import 'dart:async';
import 'dart:math';

import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/entities/obstacle_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/utils/game_status_helper.dart';
import 'package:faster/utils/obstacle_patterns.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const maxObstacleApparitionTime = 5; //sec

class ObstacleSystem extends System with UpdateSystem, GameRef<FasterGame> {
  Timer? timer;
  Query? _query;
  double elapsedTime = 0;
  int obstacleNumber = 0;
  final PatternList patternList;

  DifficultyComponent? difficultyComponent;

  ObstacleSystem(this.patternList);

  @override
  void init() {
    _query = createQuery([
      Has<PositionComponent>(),
      Has<VelocityComponent>(),
      Has<SpriteComponent>(),
    ]);
  }

  @override
  void dispose() {
    _query = null;
    super.dispose();
  }

  @override
  void update(double delta) {
    difficultyComponent ??= game!.world.entityManager.getEntityByName(gameSessionEntity)?.get<DifficultyComponent>();

    if (difficultyComponent != null && game != null && isPlaying(game!)) {
      elapsedTime += delta;

      double probability = elapsedTime / maxObstacleApparitionTime;

      if (probability > Random(1).nextDouble()) {
        elapsedTime = 0;

        final nextPattern = patternList.getNextPattern();

        for (int index = 0; index < nextPattern.obstacles.length; index++) {
          final obstacle = nextPattern.obstacles[index];

          createObstacle(
            obstacleNumber + index,
            Random().nextInt(obstacleSizes.length),
            game!,
            positionX: obstacle.posX,
            positionY: obstacle.posY,
          );
        }
      }

      for (final entity in _query?.entities ?? <Entity>[]) {
        final velocity = entity.get<VelocityComponent>()!.velocity;
        var position = entity.get<PositionComponent>()!.position;
        final size = entity.get<SizeComponent>()!.size;

        if (position.x > -size.x) {
          position.add((velocity * delta * (1 + log(difficultyComponent!.difficulty.toDouble()))));
        } else {
          entity.dispose();
        }
      }
    }
  }
}
