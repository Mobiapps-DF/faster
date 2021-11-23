import 'package:faster/components/animated_sprites_component.dart';
import 'package:faster/components/tap_input_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const playerEntity = 'Player';

Future<Entity> createPlayer(FasterGame game) async {
  final runSprites = [
    await game.loadSprite('character_maleAdventurer_run0.png'),
    await game.loadSprite('character_maleAdventurer_run1.png'),
    await game.loadSprite('character_maleAdventurer_run2.png'),
  ];
  final jumpSprites = [
    await game.loadSprite('character_maleAdventurer_jump.png'),
  ];

  return game.createEntity(
      name: playerEntity,
      position: Vector2(50, game.world.game.size.y - 100),
      size: Vector2.all(64),
    )
      // ..add<SpriteComponent, SpriteInit>(SpriteInit(await game.loadSprite('character.png')))
      ..add<AnimatedSpritesComponent, List<SpriteAnimation>>([
          SpriteAnimation.spriteList(runSprites, stepTime: 0.15),
          SpriteAnimation.spriteList(jumpSprites, stepTime: 0.15),
        ])
      ..add<VelocityComponent, Vector2>(
        Vector2(0, 150),
      )
      ..add<TapInputComponent, bool>(false);
}
