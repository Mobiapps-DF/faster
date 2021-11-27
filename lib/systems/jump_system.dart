import 'package:faster/components/animated_sprites_component.dart';
import 'package:faster/components/tap_input_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/faster_game.dart';
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
      Has<AnimatedSpritesComponent>(),
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
      final animatedSprites = entity.get<AnimatedSpritesComponent>()!;
      Vector2 deltaPosition;

      if (isTapped != _lastTappedState) {
        entity.get<VelocityComponent>()!.reset();
        _lastTappedState = isTapped;
      }
      
      if (isTapped) {
        animatedSprites.activeAnimation = 1;
        deltaPosition = (velocity + (_jumpForce * delta / 2)) * delta;

        if (position.y + deltaPosition.y > 0) {
          position.add(deltaPosition);
          velocity.add(_jumpForce * delta);
        } else {
          entity.get<VelocityComponent>()!.reset();
        }
      } else {
        animatedSprites.activeAnimation = 0;
        deltaPosition = (velocity + (_gravity * delta / 2)) * delta;

        if (position.y + size.y + deltaPosition.y < screenSize.y) {
          position.add(deltaPosition);
          velocity.add(_gravity * delta);
        } else {
          entity.get<VelocityComponent>()!.reset();
        }
      }
    }
  }
}
