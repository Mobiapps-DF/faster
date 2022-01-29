import 'package:faster/entities/player_entity.dart';
import 'package:flame/extensions.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

Rect getHitBox(Entity entity) {
  final size = entity.get<SizeComponent>()!.size;
  final position = entity.get<PositionComponent>()!.position;

  if (entity.name == playerEntity) {
    final hitboxSize = Vector2(size.x / 2, size.y * 4 / 5);
    return Vector2(position.x + size.x / 4, position.y + size.y / 5)
      .toPositionedRect(hitboxSize);
  }

  return position.toPositionedRect(size);
}
