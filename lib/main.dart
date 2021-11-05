import 'package:faster/components/velocity_component.dart';
import 'package:faster/systems/move_system.dart';
import 'package:faster/systems/sprite_system.dart';
import 'package:flame/game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';
import 'package:flutter/material.dart';


void main() {
  final fasterGame = FasterGame();

  runApp(GameWidget(game: fasterGame));
}

class FasterGame extends OxygenGame {
  FasterGame();

  @override
  Future<void> init() async {
    world.registerSystem(MoveSystem());
    world.registerSystem(SpriteSystem());

    world.registerComponent<VelocityComponent, Vector2>(
      () => VelocityComponent(),
    );

    createEntity(
      name: 'Player',
      position: Vector2(10, 0),
      size: Vector2.all(64),
    )
      ..add<SpriteComponent, SpriteInit>(
        SpriteInit(await loadSprite('character.png'))
      )
      ..add<VelocityComponent, Vector2>(
        Vector2(0, 80), 
      );
  }
}
