import 'package:faster/components/game_status_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class ParticleDisposalSystem extends System with UpdateSystem, GameRef<FasterGame> {
  Query? _query;

  @override
  void init() {
    _query = createQuery([
      Has<ParticleComponent>(),
    ]);
  }

  @override
  void update(double delta) {
    GameStatus? status =
        game!.world.entityManager.getEntityByName(gameSessionEntity)?.get<GameStatusComponent>()?.status;

    if (status != GameStatus.dead && status != GameStatus.paused) {
      for (final entity in _query?.entities ?? <Entity>[]) {
        if (entity.get<ParticleComponent>()?.particle?.shouldRemove ?? false) {
          entity.dispose();
        }
      }
    }
  }
}
