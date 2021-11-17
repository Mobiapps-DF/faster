import 'package:flame_oxygen/flame_oxygen.dart';

class DifficultyComponent extends Component<int> {
  late int difficulty;

  @override
  void init([int? data]) {
    difficulty = data ?? 1;
  }

  @override
  void reset() {
    difficulty = 1;
  }
}
