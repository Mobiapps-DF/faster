import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:faster/components/hitbox_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const obstacleEntity = 'Obstacle';

Future<Entity> createObstacle(int number, FasterGame game) async {
  Random random = Random();
  return game.createEntity(
    name: '$obstacleEntity$number',
    position: Vector2(game.size.x - 50,
        random.nextDouble() * (game.size.y) - 128),
    size: Vector2.all(128),
  )
    ..add<SpriteComponent, SpriteInit>(
        SpriteInit(await game.loadSprite('brickSpecial${NumberFormat('00').format(random.nextInt(9) + 1)}.png')))
    ..add<VelocityComponent, Vector2>(
      Vector2(-200, 0),
    )
  ..add<HitBoxComponent, void>();
}