import 'package:faster/components/game_status_component.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/layers/faster_home.dart';
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
        _lastStatus = newStatus;
        switch (entity.get<GameStatusComponent>()!.status) {
          case GameStatus.home:
            game!.overlays.add(FasterHome.name);
            break;
          case GameStatus.playing:
            game!.overlays.remove(FasterHome.name);
            break;
          case GameStatus.dead:
          // TODO: Handle this case.
            break;
          case GameStatus.paused:
          // TODO: Handle this case.
            break;
        }
      }
    }
  }
}
