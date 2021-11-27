import 'package:faster/components/animated_sprites_component.dart';
import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/game_status_component.dart';
import 'package:faster/components/parallax_component.dart';
import 'package:faster/components/tap_input_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/entities/background_entity.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/entities/player_entity.dart';
import 'package:faster/systems/animated_sprite_system.dart';
import 'package:faster/systems/background_system.dart';
import 'package:faster/systems/difficulty_system.dart';
import 'package:faster/systems/game_status_system.dart';
import 'package:faster/systems/jump_system.dart';
import 'package:faster/systems/sprite_system.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class FasterGame extends OxygenGame with TapDetector {
  @override
  Future<void> init() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    world
      ..registerSystem(BackgroundSystem())
      ..registerSystem(SpriteSystem())
      ..registerSystem(GameStatusSystem())
      ..registerSystem(AnimatedSpriteSystem())
      ..registerSystem(JumpSystem())
      ..registerSystem(DifficultySystem())
      ..registerComponent<VelocityComponent, Vector2>(() => VelocityComponent())
      ..registerComponent<TapInputComponent, bool>(() => TapInputComponent())
      ..registerComponent<ParallaxComponent, Parallax>(() => ParallaxComponent())
      ..registerComponent<DifficultyComponent, int>(() => DifficultyComponent())
      ..registerComponent<GameStatusComponent, GameStatus>(() => GameStatusComponent())
      ..registerComponent<AnimatedSpritesComponent, List<SpriteAnimation>>(() => AnimatedSpritesComponent());

    createGameSession(this);
    await createPlayer(this);
    await createBackground(this);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    final player = world.entityManager.getEntityByName(playerEntity);

    player?.get<TapInputComponent>()!.value = true;
    return true;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    final player = world.entityManager.getEntityByName(playerEntity);

    player?.get<TapInputComponent>()!.value = false;
    return true;
  }
}
