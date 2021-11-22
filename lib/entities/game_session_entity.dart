import 'package:faster/components/difficulty_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const gameSessionEntity = 'GameSession';

Entity createGameSession(FasterGame game) =>
    game.world.createEntity(gameSessionEntity)..add<DifficultyComponent, int>(1);
