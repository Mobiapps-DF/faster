import 'package:faster/components/animated_sprites_component.dart';
import 'package:faster/components/game_status_component.dart';
import 'package:faster/components/tap_input_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/extensions.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class JumpSystem extends System with UpdateSystem, GameRef<FasterGame> {
  final _gravity = Vector2(0, 2000);
  final _jumpForce = Vector2(0, -2000);
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
    GameStatus? status = game!.world.entityManager.getEntityByName(gameSessionEntity)?.get<GameStatusComponent>()?.status;

    if (status != GameStatus.dead && status != GameStatus.paused) {
      // https://gamedev.stackexchange.com/questions/15708/how-can-i-implement-gravity
      for (final entity in _query?.entities ?? <Entity>[]) {
        final isTapped = entity.get<TapInputComponent>()!.value;
        final velocity = entity.get<VelocityComponent>()!.velocity;
        final position = entity.get<PositionComponent>()!.position;
        final screenSize = game!.size;
        final size = entity.get<SizeComponent>()!.size;
        final animatedSprites = entity.get<AnimatedSpritesComponent>()!;
        Vector2 currentAcceleration;
        Vector2 deltaPosition;

        // Tap detection
        if (isTapped) {
          animatedSprites.activeAnimation = 1;
          currentAcceleration = _jumpForce;
        } else {
          animatedSprites.activeAnimation = 0;
          currentAcceleration = _gravity;
        }
        // We compute the delta that will be added to position on next frame
        deltaPosition = (velocity + (currentAcceleration * delta / 2)) * delta;

        if (position.y + deltaPosition.y < 0) {
          // Is about to hit top
          position.add(Vector2(0, -position.y));
          entity.get<VelocityComponent>()!.reset();
        } else if (position.y + size.y + deltaPosition.y > screenSize.y) {
          // Is about to hit bottom
          position.add(Vector2(0, screenSize.y - (position.y + size.y)));
          entity.get<VelocityComponent>()!.reset();
        } else {
          // Is between bounds
          position.add(deltaPosition);
          velocity.add(currentAcceleration * delta);
        }
      }
    }
  }
}
