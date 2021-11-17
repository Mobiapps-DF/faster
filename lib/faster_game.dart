import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/parallax_component.dart';
import 'package:faster/components/tap_input_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/systems/background_system.dart';
import 'package:faster/systems/jump_system.dart';
import 'package:faster/systems/sprite_system.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class FasterGame extends OxygenGame with TapDetector {
  double speed = 10;

  @override
  Future<void> init() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    world
      ..registerSystem(BackgroundSystem())
      ..registerSystem(SpriteSystem())
      ..registerSystem(JumpSystem())
      ..registerComponent<VelocityComponent, Vector2>(() => VelocityComponent())
      ..registerComponent<TapInputComponent, bool>(() => TapInputComponent())
      ..registerComponent<ParallaxComponent, Parallax>(() => ParallaxComponent())
      ..registerComponent<DifficultyComponent, int>(() => DifficultyComponent());

    createEntity(
      name: 'Player',
      position: Vector2(50, world.game.size.y - 100),
      size: Vector2.all(64),
    )
      ..add<SpriteComponent, SpriteInit>(SpriteInit(await loadSprite('character.png')))
      ..add<VelocityComponent, Vector2>(
        Vector2(0, 150),
      )
      ..add<TapInputComponent, bool>(false);

    var parallax = await loadParallax(
      [ParallaxImageData('background.png'), ParallaxImageData('groundGrass.png')],
      baseVelocity: Vector2(speed, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );

    createEntity(
      name: 'Background',
      position: Vector2(0, 0),
      size: size,
    )
      ..add<ParallaxComponent, Parallax>(parallax)
      ..add<DifficultyComponent, int>();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    final player = world.entityManager.getEntityByName('Player');

    player?.get<TapInputComponent>()!.value = true;
    return true;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    final player = world.entityManager.getEntityByName('Player');

    player?.get<TapInputComponent>()!.value = false;
    return true;
  }
}
