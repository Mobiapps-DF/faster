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
import 'package:faster/systems/debug_system.dart';
import 'package:faster/systems/difficulty_system.dart';
import 'package:faster/systems/game_status_system.dart';
import 'package:faster/systems/jump_system.dart';
import 'package:faster/systems/sprite_system.dart';
import 'package:faster/utils/game_status_helper.dart';
import 'package:faster/systems/obstacle_system.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_oxygen/flame_oxygen.dart';
import 'dart:math';

class FasterGame extends OxygenGame with TapDetector {
  @override
  Future<void> init() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    Random random = Random();

    world
      ..registerSystem(BackgroundSystem())
      ..registerSystem(SpriteSystem())
      ..registerSystem(GameStatusSystem())
      ..registerSystem(AnimatedSpriteSystem())
      ..registerSystem(JumpSystem())
      ..registerSystem(DifficultySystem())
      ..registerSystem(DebugSystem())
      ..registerSystem(ObstacleSystem())
      ..registerComponent<VelocityComponent, Vector2>(() => VelocityComponent())
      ..registerComponent<TapInputComponent, bool>(() => TapInputComponent())
      ..registerComponent<ParallaxComponent, Parallax>(() => ParallaxComponent())
      ..registerComponent<DifficultyComponent, int>(() => DifficultyComponent())
      ..registerComponent<GameStatusComponent, GameStatus>(() => GameStatusComponent())
      ..registerComponent<AnimatedSpritesComponent, List<SpriteAnimation>>(() => AnimatedSpritesComponent());

    createGameSession(this);
    await createPlayer(this);
    await createBackground(this);

    createEntity(
      name: 'Obstacle',
      position: Vector2(world.game.size.x - 50,
          random.nextDouble() * (world.game.size.y) - 128),
      size: Vector2.all(128),
    )
      ..add<SpriteComponent, SpriteInit>(
          SpriteInit(await loadSprite('brickSpecial01.png')))
      ..add<VelocityComponent, Vector2>(
        Vector2(-200, 0),
      );
  }

  @override
  void onTapCancel() => _revertIsTapped();

  @override
  void onTapDown(TapDownInfo info) => _revertIsTapped();

  @override
  void onTapUp(TapUpInfo info) => _revertIsTapped();

  void _revertIsTapped() {
    if (isPlaying(this)) {
      final player = world.entityManager.getEntityByName(playerEntity);

      player?.get<TapInputComponent>()!.revert();
    }
  }
}
