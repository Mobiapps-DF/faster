import 'dart:ui';

import 'package:faster/components/animated_sprites_component.dart';
import 'package:faster/components/game_status_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class AnimatedSpriteSystem extends BaseSystem with UpdateSystem, GameRef<FasterGame> {
  @override
  List<Filter<Component>> get filters => [Has<AnimatedSpritesComponent>()];

  @override
  void update(double delta) {
    GameStatus? status =
        game!.world.entityManager.getEntityByName(gameSessionEntity)?.get<GameStatusComponent>()?.status;

    if (status != GameStatus.dead && status != GameStatus.paused) {
      for (final entity in entities) {
        final animation = entity.get<AnimatedSpritesComponent>()!.animation;

        animation.update(delta);
      }
    }
  }

  @override
  void renderEntity(Canvas canvas, Entity entity) {
    final size = entity.get<SizeComponent>()!.size;
    final animation = entity.get<AnimatedSpritesComponent>()!.animation;

    animation.getSprite().render(canvas, size: size);
  }
}
