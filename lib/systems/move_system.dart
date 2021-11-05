import 'package:faster/components/velocity_component.dart';
import 'package:faster/main.dart';
import 'package:flame/extensions.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class MoveSystem extends System with UpdateSystem, GameRef<FasterGame> {
  Query? _query;

  @override
  void init() {
    _query = createQuery([
      Has<PositionComponent>(),
      Has<VelocityComponent>(),
      Has<SpriteComponent>(),
      // TODO: InputComponent (?)
    ]);
  }

  @override
  void dispose() {
    _query = null;
    super.dispose();
  }

  @override
  void update(double delta) {
    for (final entity in _query?.entities ?? <Entity>[]) {
      final size = entity.get<SizeComponent>()!.size;
      final velocity = entity.get<VelocityComponent>()!.velocity;
      final position = entity.get<PositionComponent>()!.position
        ..add(velocity * delta);

      final screenSize = Vector2.zero() & game!.size;
      if (!screenSize.containsPoint(position) ||
          !screenSize.containsPoint(position + size)) {
        velocity.setFrom(-velocity);
      }
    }
  }
}
