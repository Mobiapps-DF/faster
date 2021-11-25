import 'package:faster/components/velocity_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';
import 'dart:async';

class ObstacleSystem extends System with UpdateSystem, GameRef<FasterGame> {
  Timer? timer;

  Query? _query;

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
    Timer obstacleTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      // runs every 5 seconds
    });
    for (final entity in _query?.entities ?? <Entity>[]) {
      final velocity = entity.get<VelocityComponent>()!.velocity;
      var position = entity.get<PositionComponent>()!.position;
      final screenSize = game!.size;
      final size = entity.get<SizeComponent>()!.size;
      final maxObstacleApparitionTime = 5; //sec

      if (position.y + size.y <= screenSize.y) {
        position.add((velocity * delta));
      } else {
        // TODO : Destroy the obstacle
        // comme ca : entity.dispose();
      }
    }
  }
}
