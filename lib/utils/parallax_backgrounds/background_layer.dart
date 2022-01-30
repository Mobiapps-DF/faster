import 'dart:developer';
import 'dart:ui';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/src/extensions/image.dart';
import 'package:flutter/painting.dart';

/// How to fill the screen with the image, always proportionally scaled.
enum LayerFill { height, width, none }

class BackgroundLayer {
  List<Image> images;
  Vector2 velocityMultiplier;

  int _currentImageIndex = 0;
  int _previousImageIndex = 0;

  Vector2? _scroll;
  Vector2? _previousScroll;

  double? _currentImageXStart;

  Vector2? _imageSize;
  Rect? _paintArea;
  double _scale = 1.0;

  BackgroundLayer(this.images, this.velocityMultiplier);

  static Future<BackgroundLayer> load(
      List<String> paths, Vector2 velocityMultiplier, {
        Images? images,
      }) async {
    images ??= Flame.images;
    var futures = Future.wait(paths.map((String path) => images!.load(path)));
    return BackgroundLayer(
      await futures,
      velocityMultiplier
    );
  }

  void changeCurrentBackground(int newBackground) {
    assert(newBackground <= images.length);
    _previousImageIndex = _currentImageIndex;
    _currentImageIndex = newBackground;
  }

  void reset() {
    _currentImageIndex = 0;
    _previousImageIndex = 0;
  }

  void resize(Vector2 size) {
    // double scale(LayerFill fill) {
    //   switch (fill) {
    //     case LayerFill.height:
    //       return images[_currentImageIndex].height / size.y;
    //     case LayerFill.width:
    //       return images[_currentImageIndex].width / size.x;
    //     default:
    //       return _scale;
    //   }
    // }
    //
    // _scale = scale(LayerFill.height);
    _scale = images[_currentImageIndex].height / size.y;

    // The image size so that it fulfills the LayerFill parameter
    _imageSize = images[_currentImageIndex].size / _scale;

    // Number of images that can fit on the canvas plus one
    // to have something to scroll to without leaving canvas empty
    final count = Vector2.all(1) + (size.clone()..divide(_imageSize!));

    // Percentage of the image size that will overflow
    final overflow = ((_imageSize!.clone()..multiply(count)) - size)..divide(_imageSize!);

    // Align image to correct side of the screen
    const alignment = Alignment.bottomLeft;

    final marginX = alignment.x * overflow.x / 2 + overflow.x / 2;
    final marginY = alignment.y * overflow.y / 2 + overflow.y / 2;

    _scroll = Vector2(marginX, marginY);

    // Size of the area to paint the images on
    final paintSize = count..multiply(_imageSize!);
    _paintArea = paintSize.toRect();
  }

  void update(Vector2 delta, double dt) {
    if (_scroll != null && _imageSize != null && _paintArea != null) {
      // parallaxRenderer.update(dt);
      // Scale the delta so that images that are larger don't scroll faster
      _scroll = _scroll! + delta.clone()
        ..divide(_imageSize!);
      // switch (parallaxRenderer.repeat) {
      //   case ImageRepeat.repeat:
      //     _scroll = Vector2(_scroll.x % 1, _scroll.y % 1);
      //     break;
      //   case ImageRepeat.repeatX:
      _scroll = Vector2(_scroll!.x % 1, _scroll!.y);
      //     break;
      //   case ImageRepeat.repeatY:
      //     _scroll = Vector2(_scroll.x, _scroll.y % 1);
      //     break;
      //   case ImageRepeat.noRepeat:
      //     break;
      // }

      // log("ParallaxLayer.update -- _scroll: ${_scroll.toString()}");

      final scrollPosition = _scroll!.clone()
        ..multiply(_imageSize!);
      _paintArea = Rect.fromLTWH(
        -scrollPosition.x,
        -scrollPosition.y,
        _paintArea!.width,
        _paintArea!.height,
      );
    }
  }

  void render(Canvas canvas) {
    if (_paintArea?.isEmpty ?? true) {
      return;
    }
    log("rendering with paintArea: $_paintArea");
    paintImage(
      canvas: canvas,
      image: images[_currentImageIndex],
      rect: _paintArea!,
      repeat: ImageRepeat.repeatX,
      scale: _scale,
      alignment: Alignment.bottomLeft,
    );
  }
}
