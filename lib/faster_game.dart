import 'package:faster/components/animated_sprites_component.dart';
import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/game_status_component.dart';
import 'package:faster/components/hitbox_component.dart';
import 'package:faster/components/parallax_component.dart';
import 'package:faster/components/score_component.dart';
import 'package:faster/components/tap_input_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/entities/player_entity.dart';
import 'package:faster/systems/animated_sprite_system.dart';
import 'package:faster/systems/background_system.dart';
import 'package:faster/systems/collision_system.dart';
import 'package:faster/systems/debug_system.dart';
import 'package:faster/systems/difficulty_system.dart';
import 'package:faster/systems/game_status_system.dart';
import 'package:faster/systems/hitbox_system.dart';
import 'package:faster/systems/jump_system.dart';
import 'package:faster/systems/obstacle_system.dart';
import 'package:faster/systems/score_system.dart';
import 'package:faster/systems/sprite_system.dart';
import 'package:faster/utils/constants.dart';
import 'package:faster/utils/game_status_helper.dart';
import 'package:faster/utils/obstacle_patterns.dart';
import 'package:faster/utils/parallax_backgrounds/parallax_backgrounds.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

class FasterGame extends OxygenGame with TapDetector {
  final SetDoubleCallback saveScore;

  FasterGame({required this.saveScore});

  @override
  Future<void> init() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    final patternsList = await loadPatterns();
    FlameAudio.bgm.initialize();

    FlameAudio.bgm.load('music.mp3');

    await FlameAudio.audioCache.loadAll([
      'click.mp3',
      'death.mp3',
      'jump.mp3',
    ]);

    var parallaxBackgrounds = await ParallaxBackgrounds.load(baseVelocity);

    world
      ..registerSystem(BackgroundSystem(parallaxBackgrounds))
      ..registerSystem(SpriteSystem())
      ..registerSystem(GameStatusSystem())
      ..registerSystem(AnimatedSpriteSystem())
      ..registerSystem(JumpSystem())
      ..registerSystem(DifficultySystem())
      ..registerSystem(ObstacleSystem(patternsList))
      ..registerSystem(HitBoxSystem())
      ..registerSystem(CollisionSystem())
      ..registerSystem(ScoreSystem(saveScore: saveScore))
      ..registerSystem(DebugSystem())
      ..registerComponent<VelocityComponent, Vector2>(() => VelocityComponent())
      ..registerComponent<TapInputComponent, bool>(() => TapInputComponent())
      ..registerComponent<ParallaxComponent, Parallax>(() => ParallaxComponent())
      ..registerComponent<DifficultyComponent, int>(() => DifficultyComponent())
      ..registerComponent<GameStatusComponent, GameStatus>(() => GameStatusComponent())
      ..registerComponent<AnimatedSpritesComponent, List<SpriteAnimation>>(() => AnimatedSpritesComponent())
      ..registerComponent<HitBoxComponent, void>(() => HitBoxComponent())
      ..registerComponent<ScoreComponent, double>(() => ScoreComponent());

    createGameSession(this);
    await createPlayer(this);
  }

  @override
  void onTapCancel() => _revertIsTapped();

  @override
  void onTapDown(TapDownInfo info) {
    FlameAudio.play('jump.mp3', volume: 0.8);
    _revertIsTapped();
  }

  @override
  void onTapUp(TapUpInfo info) => _revertIsTapped();

  void _revertIsTapped() {
    if (isPlaying(this)) {
      final player = world.entityManager.getEntityByName(playerEntity);

      player?.get<TapInputComponent>()!.revert();
    }
  }
}
