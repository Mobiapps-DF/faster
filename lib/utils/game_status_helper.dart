import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/game_status_component.dart';
import 'package:faster/components/tap_input_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/entities/obstacle_entity.dart';
import 'package:faster/entities/player_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

bool isPlaying(FasterGame game) =>
    game.world.entityManager.getEntityByName(gameSessionEntity)?.get<GameStatusComponent>()?.status ==
    GameStatus.playing;

setPlaying(FasterGame game) {
  Entity? gameEntity = game.world.entityManager.getEntityByName(gameSessionEntity);
  if (gameEntity != null) {
    for (var entity in game.world.entities) {
      if (entity.name?.startsWith(obstacleEntity) ?? false) {
        game.world.entityManager.removeEntity(entity);
      }
    }

    gameEntity.get<DifficultyComponent>()?.difficulty = 1;
    gameEntity.get<GameStatusComponent>()?.status = GameStatus.playing;

    game.world.entityManager.processRemovedEntities();
  }
  Entity? entity = game.world.entityManager.getEntityByName(playerEntity);
  if (entity != null) {
    entity.get<VelocityComponent>()!.reset();
    entity.get<PositionComponent>()!.position.setFrom(Vector2(50, game.world.game.size.y - playerSizeY));
    entity.get<TapInputComponent>()!.value = false;
  }
}

setPaused(FasterGame game) {
  Entity? gameEntity = game.world.entityManager.getEntityByName(gameSessionEntity);
  if (gameEntity != null) {
    gameEntity.get<GameStatusComponent>()?.status = GameStatus.paused;
  }
}

unsetPause(FasterGame game) {
  Entity? gameEntity = game.world.entityManager.getEntityByName(gameSessionEntity);
  if (gameEntity != null) {
    gameEntity.get<GameStatusComponent>()?.status = GameStatus.playing;
  }
}