import 'dart:ui';

import 'package:faster/utils/parallax_backgrounds/background_layer.dart';
import 'package:flame/effects.dart';

const backgrounds = ["backgroundEmpty.png", "backgroundForest.png", "backgroundDesert.png", "backgroundCastles.png"];

class ParallaxBackgrounds {
  late Vector2 velocity;
  final List<BackgroundLayer> layers;

  ParallaxBackgrounds(this.layers, {Vector2? baseVelocity}) {
    velocity = baseVelocity ?? Vector2.zero();
  }

  static Future<ParallaxBackgrounds> load() async {
    List<BackgroundLayer> list = [];
    list.add(await BackgroundLayer.load(backgrounds, Vector2(1.8, 0.0)));
    list.add(await BackgroundLayer.load(['groundGrass.png'], Vector2(1.0, 0.0)));
    return ParallaxBackgrounds(list, baseVelocity: Vector2(10.0, 0.0));
  }

  void changeCurrentBackground() {

  }

  void resize(Vector2 size) {
    for (var layer in layers) {
      layer.resize(size);
    }
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
    for (var layer in layers) {
      layer.render(canvas);
    }
  }
}
