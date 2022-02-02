import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:faster/components/hitbox_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const obstacleEntity = 'Obstacle';

const baseObstacleVelocity = 200.0;
const obstacleSizeFactors = [6, 7];

Future<Entity> createObstacle(
  int number,
  int obstacleSizeIndex,
  FasterGame game,
  {
    required double positionX,
    required double positionY,
    required double deltaX,
    required double deltaY,
  }
) async {
  Random random = Random();

  // final xVariation = (random.nextDouble() * 2 - 1) * deltaX;
  final yVariation = (random.nextDouble() * 2 - 1) * deltaY;
  final obstacleSize = game.size.y / obstacleSizeFactors[obstacleSizeIndex];

  return game.createEntity(
    name: '$obstacleEntity$number',
    position: Vector2(
      (game.size.x + positionX * game.size.x),
      (positionY * (game.size.y - obstacleSize)) * (1 + yVariation),
    ),
    size: Vector2.all(
      obstacleSize,
    ),
  )
    ..add<SpriteComponent, SpriteInit>(
        SpriteInit(await game.loadSprite('brickSpecial${NumberFormat('00').format(random.nextInt(9) + 1)}.png')))
    ..add<VelocityComponent, Vector2>(
      Vector2(-baseObstacleVelocity, 0),
    )
    ..add<HitBoxComponent, void>();
}
