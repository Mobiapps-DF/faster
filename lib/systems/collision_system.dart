import 'package:faster/components/game_status_component.dart';
import 'package:faster/components/hitbox_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/entities/player_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/utils/game_status_helper.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class CollisionSystem extends System with UpdateSystem, GameRef<FasterGame> {
  Query? _query;

  @override
  void init() {
    _query = createQuery([
      Has<PositionComponent>(),
      Has<VelocityComponent>(),
      Has<SpriteComponent>(),
      Has<HitBoxComponent>(),
    ]);
  }

  @override
  void dispose() {
    _query = null;
    super.dispose();
  }

  @override
  void update(double delta) {
    if (game != null && isPlaying(game!)) {
      final playerHitBox = game!.world.entityManager.getEntityByName(playerEntity)!.get<HitBoxComponent>()!.value!;

      for (final entity in _query?.entities ?? <Entity>[]) {
        if (entity.get<HitBoxComponent>()!.value!.overlaps(playerHitBox)) {
          game!.world.entityManager.getEntityByName(gameSessionEntity)!.get<GameStatusComponent>()!.status =
              GameStatus.dead;
        }
      }
    }
  }
}
