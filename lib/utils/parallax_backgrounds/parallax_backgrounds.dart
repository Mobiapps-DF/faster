import 'dart:ui';

import 'package:faster/utils/parallax_backgrounds/background_layer.dart';
import 'package:flame/effects.dart';

const backgrounds = ["backgroundEmpty.png", "backgroundForest.png", "backgroundDesert.png", "backgroundCastles.png"];

class ParallaxBackgrounds {
  late Vector2 velocity;
  final List<BackgroundLayer> layers;
  late Rect _clipRect;
  bool isSized = false;
  late final Vector2 _size;

  ParallaxBackgrounds(this.layers, Vector2 baseVelocity) {
    velocity = baseVelocity;
  }

  static Future<ParallaxBackgrounds> load(Vector2 baseVelocity) async {
    List<BackgroundLayer> list = [];
    list.add(await BackgroundLayer.load(backgrounds, Vector2(2.0, 1.0)));
    list.add(await BackgroundLayer.load(['groundGrass.png'], Vector2(3.6, 1.0)));
    return ParallaxBackgrounds(list, baseVelocity);
  }

  void changeCurrentBackground() {}

  void resize(Vector2 newSize) {
    if (!isSized) {
      _size = Vector2.zero();
    }
    if (newSize != _size || !isSized) {
      _size.setFrom(newSize);
      _clipRect = _size.toRect();
      for (var layer in layers) {
        layer.resize(_size);
      }
    }
    isSized |= true;
  }

  void reset() {
    for (var layer in layers) {
      layer.reset();
    }
  }

  void update(double dt) {
    for (var layer in layers) {
      layer.update((velocity.clone()..multiply(layer.velocityMultiplier)) * dt, dt);
    }
  }

  void render(Canvas canvas) {
    canvas.save();
    canvas.clipRect(_clipRect);
    for (var layer in layers) {
      canvas.save();
      layer.render(canvas);
      canvas.restore();
    }
    canvas.restore();
  }
}
