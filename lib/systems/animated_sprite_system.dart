import 'dart:ui';

import 'package:faster/components/animated_sprites_component.dart';
import 'package:faster/components/game_status_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/entities/player_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class AnimatedSpriteSystem extends BaseSystem with UpdateSystem, GameRef<FasterGame> {
  Entity? _player;

  @override
  List<Filter<Component>> get filters => [Has<AnimatedSpritesComponent>()];

  @override
  void update(double delta) {
    GameStatus? status =
        game!.world.entityManager.getEntityByName(gameSessionEntity)?.get<GameStatusComponent>()?.status;

    if (status != GameStatus.dead) {
      if (status != GameStatus.paused) {
        for (final entity in entities) {
          final animation = entity.get<AnimatedSpritesComponent>()!.animation;

          animation.update(delta);
        }
      }
    } else {
      _player ??= game!.world.entityManager.getEntityByName(playerEntity);

      final velocity = _player?.get<VelocityComponent>()!.velocity?..add(Vector2(0, delta));
      _player?.get<PositionComponent>()!.position.add(Vector2(0, velocity!.y * 2));
    }
  }

  @override
  void renderEntity(Canvas canvas, Entity entity) {
    final size = entity.get<SizeComponent>()!.size;
    final animation = entity.get<AnimatedSpritesComponent>()!.animation;

    animation.getSprite().render(canvas, size: size);
  }
}
