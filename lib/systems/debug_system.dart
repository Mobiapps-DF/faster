import 'dart:developer';

import 'package:faster/components/game_status_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

/// 10 seconds
const debugGameLength = 10;

class DebugSystem extends System with UpdateSystem, GameRef<FasterGame> {
  Query? _query;
  GameStatus _lastStatus = GameStatus.home;
  double _elapsedGameTime = 0;

  List<Entity> get entities => _query?.entities ?? [];

  @override
  void init() {
    _query = createQuery([Has<GameStatusComponent>()]);
  }

  @override
  void dispose() {
    _query = null;
    super.dispose();
  }

  @override
  void update(double delta) {
    log('DebugSystem -- 1 update($delta)');
    for (final entity in entities) {
      var newStatus = entity.get<GameStatusComponent>()!.status;
      if (newStatus != _lastStatus) {
        log('DebugSystem -- 2 $_lastStatus / $newStatus');
        _lastStatus = newStatus;
        switch (newStatus) {
          case GameStatus.home:
            _elapsedGameTime = 0;
            break;
          case GameStatus.dead:
            _elapsedGameTime = 0;
            break;
          case GameStatus.playing:
          case GameStatus.paused:

            /// nothing to do
            break;
        }
      } else {
        log('DebugSystem -- 3 $newStatus');
        if (newStatus == GameStatus.playing) {
          _elapsedGameTime += delta;
          log('DebugSystem -- 4 $_elapsedGameTime');
          if (_elapsedGameTime > debugGameLength) {
            log('DebugSystem -- 5 you are dead');
            entity.get<GameStatusComponent>()!.status = GameStatus.dead;
          }
        }
      }
    }
  }
}
