import 'package:faster/components/tap_input_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/main.dart';
import 'package:flame/extensions.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class JumpSystem extends System with UpdateSystem, GameRef<FasterGame> {
  final _gravity = Vector2(0, 2000);
  final _jumpForce = Vector2(0, -2000);
  bool _lastTappedState = false;
  Query? _query;

  @override
  void init() {
    _query = createQuery([
      Has<PositionComponent>(),
      Has<VelocityComponent>(),
      Has<SpriteComponent>(),
      Has<TapInputComponent>(),
    ]);
  }

  @override
  void dispose() {
    _query = null;
    super.dispose();
  }

  @override
  void update(double delta) {
    // https://gamedev.stackexchange.com/questions/15708/how-can-i-implement-gravity
    for (final entity in _query?.entities ?? <Entity>[]) {
      final isTapped = entity.get<TapInputComponent>()!.value!;
      final velocity = entity.get<VelocityComponent>()!.velocity;
      final position = entity.get<PositionComponent>()!.position;
      final screenSize = game!.size;
      final size = entity.get<SizeComponent>()!.size;

      if (isTapped != _lastTappedState) {
        entity.get<VelocityComponent>()!.reset();
        _lastTappedState = isTapped;
      }
      
      if (isTapped) {
        if (position.y >= 0) {
          position.add((velocity + (_jumpForce * delta / 2)) * delta);
          velocity.add(_jumpForce * delta);
        } else {
          entity.get<VelocityComponent>()!.reset();
        }
      } else {
        if (position.y + size.y <= screenSize.y) {
          position.add((velocity + (_gravity * delta / 2)) * delta);
          velocity.add(_gravity * delta);
        } else {
          entity.get<VelocityComponent>()!.reset();
        }
      }
    }
  }
}
