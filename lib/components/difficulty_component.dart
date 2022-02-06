import 'package:flame_oxygen/flame_oxygen.dart';

class DifficultyComponent extends Component<double> {
  late double difficulty;

  @override
  void init([double? data]) {
    difficulty = data ?? 1;
  }

  @override
  void reset() {
    difficulty = 1;
  }
}
