import 'dart:ui';

import 'package:faster/components/animated_sprite_component.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class AnimatedSpriteSystem extends BaseSystem with UpdateSystem {
  @override
  List<Filter<Component>> get filters => [Has<AnimatedSpriteComponent>()];

  @override
  void update(double dt) {
    for (final entity in entities) {
      final animation = entity.get<AnimatedSpriteComponent>()!.animation;
      
      animation.update(dt);
    }
  }
  
  @override
  void renderEntity(Canvas canvas, Entity entity) {
    final size = entity.get<SizeComponent>()!.size;
    final animation = entity.get<AnimatedSpriteComponent>()!.animation;

    animation.getSprite().render(canvas, size: size);
  }
}
