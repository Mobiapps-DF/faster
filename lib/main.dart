import 'package:faster/components/tap_input_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/systems/jump_system.dart';
import 'package:faster/systems/sprite_system.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_oxygen/flame_oxygen.dart';
import 'package:flutter/material.dart';


void main() {
  final fasterGame = FasterGame();

  runApp(GameWidget(game: fasterGame));
}

class FasterGame extends OxygenGame with TapDetector {
  FasterGame();

  @override
  Future<void> init() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    world.registerSystem(SpriteSystem());
    world.registerSystem(JumpSystem());

    world.registerComponent<VelocityComponent, Vector2>(
      () => VelocityComponent(),
    );

    world.registerComponent<TapInputComponent, bool>(
      () => TapInputComponent(),
    );

    createEntity(
      name: 'Player',
      position: Vector2(50, world.game.size.y - 100),
      size: Vector2.all(64),
    )
      ..add<SpriteComponent, SpriteInit>(
        SpriteInit(await loadSprite('character.png'))
      )
      ..add<VelocityComponent, Vector2>(
        Vector2(0, 150),
      )
      ..add<TapInputComponent, bool>(false);
  }

  @override
  bool onTapDown(TapDownInfo event) {
    final player = world.entityManager.getEntityByName('Player');

    player?.get<TapInputComponent>()!.value = true;
    return true;
  }

  @override
  bool onTapUp(TapUpInfo event) {
    final player = world.entityManager.getEntityByName('Player');

    player?.get<TapInputComponent>()!.value = false;
    return true;
  }
}
