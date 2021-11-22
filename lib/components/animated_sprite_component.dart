import 'package:flame_oxygen/flame_oxygen.dart';


class AnimatedSpriteComponent extends Component<SpriteAnimation> {
  late SpriteAnimation animation;
  
  @override
  void init([SpriteAnimation? data]) {
    animation = data ?? SpriteAnimation.empty();
  }

  @override
  void reset() {
    animation = SpriteAnimation.empty();
  }
}