import 'dart:ui';

import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/parallax_component.dart';
import 'package:faster/entities/background_entity.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class BackgroundSystem extends BaseSystem with UpdateSystem, GameRef<FasterGame> {
  DifficultyComponent? difficultyComponent;

  @override
  List<Filter<Component>> get filters => [Has<ParallaxComponent>(), Has<DifficultyComponent>()];

  @override
  void update(double delta) {
    difficultyComponent ??= game!.world.entityManager.getEntityByName(gameSessionEntity)?.get<DifficultyComponent>();

    if (difficultyComponent != null) {
      for (var element in entities) {
        element.get<ParallaxComponent>()?.parallax?.update(delta);
        element.get<ParallaxComponent>()?.parallax?.baseVelocity =
            Vector2(baseSpeed * difficultyComponent!.difficulty, 0);
      }
    }
  }

  @override
  void renderEntity(Canvas canvas, Entity entity) => entity.get<ParallaxComponent>()?.parallax?.render(canvas);
}
