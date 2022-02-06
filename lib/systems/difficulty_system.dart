import 'package:faster/components/difficulty_component.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/utils/game_status_helper.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const timeBeforeIncrease = 15;

class DifficultySystem extends System with UpdateSystem, GameRef<FasterGame> {
  Query? _query;
  // double elapsedTime = 0;

  @override
  void init() {
    _query = createQuery([Has<DifficultyComponent>()]);
  }

  @override
  void dispose() {
    _query = null;
    super.dispose();
  }

  @override
  void update(double delta) {
    if (game != null && isPlaying(game!)) {
      // elapsedTime += delta;
      // if (elapsedTime > timeBeforeIncrease) {
      //   elapsedTime = 0;
        for (final entity in _query?.entities ?? <Entity>[]) {
          entity.get<DifficultyComponent>()?.difficulty += delta / timeBeforeIncrease;
        }
    //   }
    }
  }
}
