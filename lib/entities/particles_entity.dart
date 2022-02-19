import 'dart:math';

import 'package:faster/faster_game.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flame_oxygen/flame_oxygen.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

const particlesEntity = 'Particles';

final rnd = Random();

final RandomColor _randomColor = RandomColor();

Entity createParticles(FasterGame game, Vector2 position) => game.world.entityManager.createEntity(particlesEntity)
  ..add<ParticleComponent, Particle>(AcceleratedParticle(
    position: position,
    speed: Vector2(rnd.nextDouble() * 20 - 20, rnd.nextDouble() * 100 + 200),
    child: CircleParticle(
      radius: 2.0,
      paint: Paint()
        ..color = _randomColor.randomColor(
            colorHue: ColorHue.multiple(colorHues: [ColorHue.yellow, ColorHue.orange]),
            colorBrightness: ColorBrightness.light),
    ),
  ));
