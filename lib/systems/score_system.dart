import 'package:faster/components/game_status_component.dart';
import 'package:faster/components/parallax_component.dart';
import 'package:faster/components/score_component.dart';
import 'package:faster/entities/background_entity.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/entities/player_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/utils/colors.dart';
import 'package:flame/game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';
import 'package:flutter/material.dart';

final TextPaint textPaint = TextPaint(
  style: const TextStyle(
    fontSize: 24.0,
    fontFamily: 'RoadRage',
    color: appLightBlue,
  ),
);

class ScoreSystem extends System with UpdateSystem, RenderSystem, GameRef<FasterGame> {
  Query? _query;

  @override
  void init() {
    _query = createQuery([
      Has<ScoreComponent>(),
    ]);
  }

  @override
  void update(double delta) {
    GameStatus? status =
        game!.world.entityManager.getEntityByName(gameSessionEntity)?.get<GameStatusComponent>()?.status;
    final scoreComponent = game!.world.entityManager
        .getEntityByName(playerEntity)
        !.get<ScoreComponent>()!;

    if (status == GameStatus.playing) {
      final speed = game!.world.entityManager
          .getEntityByName(backgroundEntity)
          ?.get<ParallaxComponent>()?.parallax?.baseVelocity;

      if (speed != null) {
        scoreComponent.addToScore(speed.x * delta);
      }
    }

    if (status == GameStatus.dead && scoreComponent.realScore != 0) {
      scoreComponent.reset();
    }
  }

  @override
  void render(Canvas canvas) {
    for (final entity in _query?.entities ?? <Entity>[]) {
      final score = entity.get<ScoreComponent>()?.roundedScore ?? 0;

      textPaint.render(canvas, '$score', Vector2(10, 10));
    }
  }
}
