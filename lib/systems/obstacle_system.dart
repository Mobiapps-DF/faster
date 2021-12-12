import 'dart:async';

import 'package:faster/components/velocity_component.dart';
import 'package:faster/entities/obstacle_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/utils/game_status_helper.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const maxObstacleApparitionTime = 5; //sec

class ObstacleSystem extends System with UpdateSystem, GameRef<FasterGame> {
  Timer? timer;
  Query? _query;
  double elapsedTime = 0;

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
    if (game != null && isPlaying(game!)) {
      elapsedTime += delta;
      // TODO: partir plutot sur une probabilité d'apparition en fonction du temps ecoule
      if (elapsedTime > maxObstacleApparitionTime) {
        elapsedTime = 0;
        createObstacle(game!);
      }

      for (final entity in _query?.entities ?? <Entity>[]) {
        final velocity = entity.get<VelocityComponent>()!.velocity;
        var position = entity.get<PositionComponent>()!.position;
        final screenSize = game!.size;
        final size = entity.get<SizeComponent>()!.size;

        if (position.y + size.y <= screenSize.y) {
          position.add((velocity * delta));
        } else {
          entity.dispose();
        }
      }
    }
  }
}
