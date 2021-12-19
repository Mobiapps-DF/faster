import 'package:faster/components/game_status_component.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/layers/faster_dead_layer.dart';
import 'package:faster/layers/faster_home_layer.dart';
import 'package:faster/layers/faster_paused_layer.dart';
import 'package:faster/layers/faster_playing_layer.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class GameStatusSystem extends System with UpdateSystem, GameRef<FasterGame> {
  Query? _query;
  GameStatus _lastStatus = GameStatus.home;

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
    for (final entity in entities) {
      var newStatus = entity.get<GameStatusComponent>()!.status;
      if (newStatus != _lastStatus) {
        _unloadStatus(_lastStatus);
        _lastStatus = newStatus;
        _loadStatus(newStatus);
      }
    }
  }

  void _unloadStatus(GameStatus status) {
    switch (status) {
      case GameStatus.home:
        game!.overlays.remove(FasterHome.name);
        break;
      case GameStatus.playing:
        game!.overlays.remove(FasterPlaying.name);
        break;
      case GameStatus.dead:
        game!.overlays.remove(FasterDead.name);
        break;
      case GameStatus.paused:
        game!.overlays.remove(FasterPaused.name);
        break;
    }
  }

  void _loadStatus(GameStatus status) {
    switch (status) {
      case GameStatus.home:
        game!.overlays.add(FasterHome.name);
        break;
      case GameStatus.playing:
        game!.overlays.add(FasterPlaying.name);
        break;
      case GameStatus.dead:
        game!.overlays.add(FasterDead.name);
        break;
      case GameStatus.paused:
        game!.overlays.add(FasterPaused.name);
        break;
    }
  }
}
