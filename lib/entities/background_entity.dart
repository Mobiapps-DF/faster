import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/parallax_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const baseSpeed = 10.0;

Future<Entity> createBackground(FasterGame game) async {
  var parallax = await game.loadParallax(
    [ParallaxImageData('background.png'), ParallaxImageData('groundGrass.png')],
    baseVelocity: Vector2(baseSpeed, 0),
    velocityMultiplierDelta: Vector2(1.8, 1.0),
  );

  return game.createEntity(
    name: 'Background',
    position: Vector2(0, 0),
    size: game.size,
  )
    ..add<ParallaxComponent, Parallax>(parallax)
    ..add<DifficultyComponent, int>();
}
