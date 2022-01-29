import 'package:flame_oxygen/flame_oxygen.dart';

class ScoreComponent extends Component<double> {
  late double _realScore;

  @override
  void init([double? data]) => _realScore = data ?? 0;

  @override
  void reset() => init();

  void addToScore(double addition) => _realScore += addition;

  int get roundedScore => _realScore.round();

  double get realScore => _realScore;
}
