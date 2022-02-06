import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/game_status_component.dart';
import 'package:faster/components/score_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/entities/player_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/utils/colors.dart';
import 'package:faster/utils/constants.dart';
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

const double scoreMultiplier = 0.25;

typedef SetDoubleCallback = void Function(double);

class ScoreSystem extends System with UpdateSystem, RenderSystem, GameRef<FasterGame> {
  Query? _query;
  final SetDoubleCallback saveScore;

  ScoreSystem({required this.saveScore});

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
    final scoreComponent = game!.world.entityManager.getEntityByName(playerEntity)!.get<ScoreComponent>()!;

    if (status == GameStatus.playing) {
      final difficulty = game!.world.entityManager
          .getEntityByName(gameSessionEntity)
          ?.get<DifficultyComponent>()
          ?.difficulty
          .toDouble();

      if (difficulty != null) {
        final speed = baseVelocity * difficulty;

        scoreComponent.addToScore(speed.x * delta * scoreMultiplier);
      }
    }

    if (status == GameStatus.dead && scoreComponent.realScore != 0) {
      _resetScoreAndHighScore(scoreComponent);
    }
  }

  @override
  void render(Canvas canvas) {
    for (final entity in _query?.entities ?? <Entity>[]) {
      final score = entity.get<ScoreComponent>()?.roundedScore ?? 0;

      textPaint.render(canvas, '$score', Vector2(20, 10));
    }
  }

  void _resetScoreAndHighScore(ScoreComponent scoreComponent) {
    saveScore(scoreComponent.realScore);
    scoreComponent.reset();
  }
}
