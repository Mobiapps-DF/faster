import 'package:faster/components/velocity_component.dart';
import 'package:faster/main.dart';
import 'package:flame/extensions.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class JumpSystem extends System with UpdateSystem, GameRef<FasterGame> {
  final _gravity = Vector2(0, 400);
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
      // https://gamedev.stackexchange.com/questions/15708/how-can-i-implement-gravity
      final velocity = entity.get<VelocityComponent>()!.velocity;
      final position = entity.get<PositionComponent>()!.position
        ..add((velocity + (_gravity * delta / 2)) * delta);
      velocity.add(_gravity * delta);

      final screenSize = Vector2.zero() & game!.size;
      final size = entity.get<SizeComponent>()!.size;
      if (!screenSize.containsPoint(position) ||
          !screenSize.containsPoint(position + size)) {
        velocity.setFrom(-velocity);
      }
    }
  }
}
