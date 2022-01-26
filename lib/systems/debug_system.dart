import 'package:faster/components/hitbox_component.dart';
import 'package:faster/entities/player_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/effects.dart';
import 'package:flame_oxygen/flame_oxygen.dart';
import 'package:flutter/foundation.dart';
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
    if (kDebugMode) {
      final hitbox = entity.get<HitBoxComponent>()!.value;
      final size = entity.get<SizeComponent>()!.size;
      final resetVector = entity.name == playerEntity ? Vector2(size.x / 4, size.y / 5) : Vector2.zero();
      Rect hitboxDebug;

      if (hitbox != null) {
        hitboxDebug = resetVector & Vector2(hitbox.size.width, hitbox.size.height);
      } else {
        hitboxDebug = resetVector & size;
      }

      canvas.drawRect(hitboxDebug, debugPaint);
    }
  }
}
