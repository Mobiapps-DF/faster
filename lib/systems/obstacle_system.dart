import 'dart:async';
import 'dart:math';

import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/entities/obstacle_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/utils/constants.dart';
import 'package:faster/utils/game_status_helper.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const maxObstacleApparitionDistance = 5; // whatever

class ObstacleSystem extends System with UpdateSystem, GameRef<FasterGame> {
  Timer? timer;
  Query? _query;
  double _elapsedTime = 0;
  final int _obstacleNumber = 0;

  DifficultyComponent? difficultyComponent;

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
      _elapsedTime += delta;

      double time = baseVelocity.x / difficultyComponent!.difficulty.toDouble();
      double probability = _elapsedTime / time;

      if (probability > Random(1).nextDouble()) {
        _elapsedTime = 0;
        createObstacle(_obstacleNumber, Random().nextInt(obstacleSizes.length), game!);
      }

      for (final entity in _query?.entities ?? <Entity>[]) {
        final velocity = entity.get<VelocityComponent>()!.velocity * difficultyComponent!.difficulty.toDouble();
        var position = entity.get<PositionComponent>()!.position;
        final size = entity.get<SizeComponent>()!.size;

        if (position.x > -size.x) {
          position.sub(velocity * delta);
        } else {
          entity.dispose();
        }
      }
    }
  }
}
