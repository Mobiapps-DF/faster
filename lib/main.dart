import 'dart:math';

import 'package:faster/systems/debug_system.dart';
import 'package:faster/systems/kawabunga_system.dart';
import 'package:faster/systems/move_system.dart';
import 'package:faster/systems/sprite_system.dart';
import 'package:flame/game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'components/timer_component.dart';
import 'components/velocity_component.dart';

void main() {
  final fasterGame = FasterGame();

  runApp(GameWidget(game: fasterGame));
}

class FasterGame extends OxygenGame with FPSCounter {
  FasterGame();

  @override
  Future<void> init() async {
    if (kDebugMode) {
      world.registerSystem(DebugSystem());
    }
    world.registerSystem(MoveSystem());
    world.registerSystem(SpriteSystem());
    world.registerSystem(KawabungaSystem());

    world.registerComponent<TimerComponent, double>(() => TimerComponent());
    world.registerComponent<VelocityComponent, Vector2>(
      () => VelocityComponent(),
    );

    final random = Random();
    for (var i = 0; i < 10; i++) {
      createEntity(
        name: 'Entity $i',
        position: size / 2,
        size: Vector2.all(64),
        angle: 0,
      )
        ..add<SpriteComponent, SpriteInit>(
          SpriteInit(await loadSprite('pizza.png')),
        )
        ..add<VelocityComponent, Vector2>(
          Vector2(
            random.nextDouble() * 100 * (random.nextBool() ? 1 : -1),
            random.nextDouble() * 100 * (random.nextBool() ? 1 : -1),
          ),
        );
    }
  }
}
