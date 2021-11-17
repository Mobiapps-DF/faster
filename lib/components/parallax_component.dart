import 'package:flame/parallax.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class ParallaxComponent extends Component<Parallax> {
  late Parallax? parallax;

  @override
  void init([Parallax? data]) {
    parallax = data;
  }

  @override
  void reset() {
    parallax = null;
  }
}
