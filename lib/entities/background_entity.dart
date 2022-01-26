import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/parallax_component.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/systems/background_system.dart';
import 'package:faster/utils/constants.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const backgroundEntity = 'Background';

Future<Entity> createBackground(FasterGame game) async {
  var parallax = await game.loadParallax(
    [ParallaxImageData(backgrounds[0]), ParallaxImageData('groundGrass.png')],
    baseVelocity: baseVelocity,
    velocityMultiplierDelta: Vector2(1.8, 1.0),
  );

  parallax.resize(game.size);

  return game.createEntity(
    name: backgroundEntity,
    position: Vector2(0, 0),
    size: game.size,
  )
    ..add<ParallaxComponent, Parallax>(parallax)
    ..add<DifficultyComponent, int>();
}
