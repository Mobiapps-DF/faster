import 'dart:ui';

import 'package:faster/components/game_status_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame/game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const buttonWidth = 190.0;
const buttonHeight = 60.0;

class HomeSystem extends System with RenderSystem, GameRef<FasterGame> {
  Query? _query;
  late Sprite startButton;
  late Vector2 position;

  List<Entity> get entities => _query?.entities ?? [];

  @override
  void init() {
    game!.loadSprite('button.png').then((value) => startButton = SpriteInit(value).sprite);
    position = Vector2(game!.size.x / 2 - buttonWidth / 2, game!.size.y / 2 - buttonHeight / 2);
    _query = createQuery([Has<GameStatusComponent>()]);
  }

  @override
  void dispose() {
    _query = null;
    super.dispose();
  }

  @override
  void render(Canvas canvas) {
    for (final entity in entities) {
      if (entity.get<GameStatusComponent>()!.status == GameStatus.home) {
        startButton.render(canvas, position: position, size: Vector2(buttonWidth, buttonHeight));
      }
    }
  }
}
