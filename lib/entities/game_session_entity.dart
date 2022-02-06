import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/game_status_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const gameSessionEntity = 'GameSession';

Entity createGameSession(FasterGame game) => game.world.entityManager.createEntity(gameSessionEntity)
  ..add<DifficultyComponent, double>(1)
  ..add<GameStatusComponent, GameStatus>();
