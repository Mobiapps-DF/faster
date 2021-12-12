import 'package:flame_oxygen/flame_oxygen.dart';

enum GameStatus {
  home,
  playing,
  dead,
  paused
}

class GameStatusComponent extends Component<GameStatus> {
  late GameStatus status;

  @override
  void init([GameStatus? data]) {
    status = data ?? GameStatus.home;
  }

  @override
  void reset() {
    status = GameStatus.home;
  }
}
