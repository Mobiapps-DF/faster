import 'dart:async' as async;
import 'dart:developer';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_oxygen/flame_oxygen.dart';
import 'package:flutter/material.dart';

class FasterGame extends OxygenGame {
  Parallax? _parallax;
  double speed = 1;
  late Vector2 _size;

  @override
  Future<void> init() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    loadParallax(
      [ParallaxImageData('background.png'), ParallaxImageData('groundGrass.png')],
      baseVelocity: Vector2(speed, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    ).then((value) {
      _parallax = value;
      _parallax!.resize(_size);
      async.Timer.periodic(const Duration(seconds: 1), (async.Timer timer) {
        speed += 40;
        log('increasing speed $speed');
        _parallax!.baseVelocity = Vector2(speed, 0);
      });
    });
  }

  @override
  void update(double delta) {
    _parallax?.update(delta);
    super.update(delta);
  }

  @override
  void render(Canvas canvas) {
    _parallax?.render(canvas);
    super.render(canvas);
  }

  @override
  void onGameResize(Vector2 size) {
    _size = size;
    super.onGameResize(size);
  }
}
