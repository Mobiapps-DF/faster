import 'package:faster/components/hitbox_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/effects.dart';
import 'package:flame_oxygen/flame_oxygen.dart';
import 'package:flutter/material.dart';

/// 10 seconds
const debugGameLength = 10;

class DebugSystem extends BaseSystem with GameRef<FasterGame> {
  final debugPaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke;

  @override
  List<Filter<Component>> get filters => [
        Has<HitBoxComponent>(),
        Has<SizeComponent>(),
      ];

  @override
  void renderEntity(Canvas canvas, Entity entity) {
    final size = entity.get<SizeComponent>()!.size;

    canvas.drawRect(Vector2.zero() & size, debugPaint);
  }
}
