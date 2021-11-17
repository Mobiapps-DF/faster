import 'dart:ui';

import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/parallax_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class BackgroundSystem extends BaseSystem with UpdateSystem, GameRef<FasterGame> {
  late Vector2 screenSize;
  bool hasUpdated = false; // TODO: dois y avoir moyen de faire mieux...

  @override
  List<Filter<Component>> get filters => [Has<ParallaxComponent>(), Has<DifficultyComponent>()];

  @override
  void init() {
    screenSize = game!.size;
    game!.onGameResize(screenSize);

    super.init();
  }

  @override
  void update(double delta) {
    for (var element in entities) {
      hasUpdated = true;
      // TODO: on doit setter la taille de l'objet parallax, mais les entités ne sont pas encore dispo dans la methode init
      element.get<ParallaxComponent>()?.parallax?.resize(screenSize);
      element.get<ParallaxComponent>()?.parallax?.update(delta);
      // TODO: increase background speed
      // element.get<ParallaxComponent>()?.parallax?.baseVelocity = Vector2(base_speed * difficulty, 0);
    }
  }

  @override
  void renderEntity(Canvas canvas, Entity entity) {
    if (hasUpdated) entity.get<ParallaxComponent>()?.parallax?.render(canvas);
  }
}
