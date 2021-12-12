import 'package:faster/components/hitbox_component.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/utils/hitbox_helper.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class HitBoxSystem extends System with UpdateSystem, GameRef<FasterGame> {
  Query? _query;

  @override
  void init() {
    _query = createQuery([
      Has<HitBoxComponent>(),
      Has<SizeComponent>(),
    ]);
  }

  @override
  void dispose() {
    _query = null;
    super.dispose();
  }

  @override
  void update(double delta) {
    for (final entity in _query?.entities ?? <Entity>[]) {
      entity.get<HitBoxComponent>()?.value = getHitBox(entity);
    }
  }
}
