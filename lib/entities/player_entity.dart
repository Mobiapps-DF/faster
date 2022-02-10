import 'package:faster/components/animated_sprites_component.dart';
import 'package:faster/components/hitbox_component.dart';
import 'package:faster/components/score_component.dart';
import 'package:faster/components/tap_input_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/extensions.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const String playerEntity = 'Player';

const double playerSizeYRatio = 0.25;
const double playerSizeXRatio = 0.75;

const int runAnimation = 0;
const int jumpAnimation = 1;
const int deathAnimation = 2;

Future<Entity> createPlayer(FasterGame game) async {
  final runSprites = [
    await game.loadSprite('character_maleAdventurer_run0.png'),
    await game.loadSprite('character_maleAdventurer_run1.png'),
    await game.loadSprite('character_maleAdventurer_run2.png'),
  ];
  final jumpSprites = [
    await game.loadSprite('character_maleAdventurer_jump.png'),
  ];
  final deathSprites = [
    await game.loadSprite('character_maleAdventurer_shoveBack.png'),
  ];

  final playerSizeY = game.world.game.size.y * playerSizeYRatio;
  final playerSizeX = playerSizeY * playerSizeXRatio;

  return game.createEntity(
    name: playerEntity,
    position: Vector2(50, game.world.game.size.y - playerSizeY),
    size: Vector2(
      playerSizeX,
      playerSizeY,
    ),
  )
    ..add<AnimatedSpritesComponent, List<SpriteAnimation>>([
      SpriteAnimation.spriteList(runSprites, stepTime: 0.15),
      SpriteAnimation.spriteList(jumpSprites, stepTime: 0.15),
      SpriteAnimation.spriteList(deathSprites, stepTime: 0.15),
    ])
    ..add<VelocityComponent, Vector2>(
      Vector2(0, 0),
    )
    ..add<TapInputComponent, bool>(false)
    ..add<HitBoxComponent, Rect>()
    ..add<ScoreComponent, double>(0);
}
