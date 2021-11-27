import 'package:faster/components/game_status_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/faster_game.dart';

bool isPlaying(FasterGame game) =>
    game.world.entityManager.getEntityByName(gameSessionEntity)?.get<GameStatusComponent>()?.status ==
    GameStatus.playing;

setPlaying(FasterGame game) =>
    game.world.entityManager.getEntityByName(gameSessionEntity)?.get<GameStatusComponent>()?.status =
        GameStatus.playing;
