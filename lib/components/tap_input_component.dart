import 'package:flame_oxygen/flame_oxygen.dart';

class TapInputComponent extends Component<bool> {
  late bool value;

  @override
  void init([bool? data]) => value = data ?? false;

  @override
  void reset() => value = false;

  void revert() => value = !value;
}
