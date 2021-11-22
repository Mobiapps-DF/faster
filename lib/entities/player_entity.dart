import 'package:faster/components/tap_input_component.dart';
import 'package:faster/components/velocity_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const playerEntity = 'Player';

Future<Entity> createPlayer(FasterGame game) async => game.createEntity(
      name: playerEntity,
      position: Vector2(50, game.world.game.size.y - 100),
      size: Vector2.all(64),
    )
      ..add<SpriteComponent, SpriteInit>(SpriteInit(await game.loadSprite('character.png')))
      ..add<VelocityComponent, Vector2>(
        Vector2(0, 150),
      )
      ..add<TapInputComponent, bool>(false);
