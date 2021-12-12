import 'package:flame/extensions.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

Rect getHitBox(Entity entity) {
  final size = entity.get<SizeComponent>()!.size;
  final position = entity.get<PositionComponent>()!.position;

  return position.toPositionedRect(size);
}
