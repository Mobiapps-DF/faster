import 'package:flame_oxygen/flame_oxygen.dart';


class AnimatedSpritesComponent extends Component<List<SpriteAnimation>> {
  late List<SpriteAnimation> _animations;
  int _activeAnimIndex = 0;

  SpriteAnimation get animation => _animations[_activeAnimIndex];

  set activeAnimation(int index) {
    if (index >= 0 && index < _animations.length) {
      _activeAnimIndex = index;
    }
  }
  
  @override
  void init([List<SpriteAnimation>? data]) {
    _animations = data ?? [];
  }

  @override
  void reset() {
    _animations.clear();
  }
}