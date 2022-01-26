import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';

class BackgroundLayer {
  List<Image> images;
  double velocityMultiplier;

  int _currentImageIndex = 0;
  int _previousImageIndex = 0;

  late Vector2 _scroll;
  late Vector2 _previousScroll;

  late double _currentImageXStart;

  late Rect _paintArea;

  BackgroundLayer(this.images, {this.velocityMultiplier = 1});

  void reset() {
    _currentImageIndex = 0;
    _previousImageIndex = 0;
  }

  void render(Canvas canvas) {
    if (_paintArea.isEmpty) {
      return;
    }
    paintImage(
      canvas: canvas,
      image: parallaxRenderer.image,
      rect: _paintArea,
      repeat: parallaxRenderer.repeat,
      scale: _scale,
      alignment: parallaxRenderer.alignment,
    );
  }

  void update(Vector2 delta, double dt) {
    parallaxRenderer.update(dt);
    // Scale the delta so that images that are larger don't scroll faster
    _scroll += delta.clone()..divide(_imageSize);
    switch (parallaxRenderer.repeat) {
      case ImageRepeat.repeat:
        _scroll = Vector2(_scroll.x % 1, _scroll.y % 1);
        break;
      case ImageRepeat.repeatX:
        _scroll = Vector2(_scroll.x % 1, _scroll.y);
        break;
      case ImageRepeat.repeatY:
        _scroll = Vector2(_scroll.x, _scroll.y % 1);
        break;
      case ImageRepeat.noRepeat:
        break;
    }

    log("ParallaxLayer.update -- _scroll: ${_scroll.toString()}");

    final scrollPosition = _scroll.clone()..multiply(_imageSize);
    _paintArea = Rect.fromLTWH(
      -scrollPosition.x,
      -scrollPosition.y,
      _paintArea.width,
      _paintArea.height,
    );
  }
}
