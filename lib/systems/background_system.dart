
import 'dart:ui';

import 'package:faster/components/difficulty_component.dart';
import 'package:faster/components/game_status_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/utils/parallax_backgrounds/parallax_backgrounds.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

const UPDATE_BACKGROUND_TIMEOUT = 10; // seconds

class BackgroundSystem extends System with UpdateSystem, RenderSystem, GameRef<FasterGame> {
  DifficultyComponent? _difficultyComponent;
  double _elapsedTime = 0;

  final ParallaxBackgrounds _backgrounds;

  int _currentBackground = 0;

  // @override
  // List<Filter<Component>> get filters => [Has<ParallaxComponent>()];

  BackgroundSystem(this._backgrounds);

  @override
  void update(double delta) {
    // _elapsedTime += delta;
    //
    // GameStatus? status =
    //     game!.world.entityManager.getEntityByName(gameSessionEntity)?.get<GameStatusComponent>()?.status;
    //
    // if (status != GameStatus.dead && status != GameStatus.paused) {
    //   _difficultyComponent ??= game!.world.entityManager.getEntityByName(gameSessionEntity)?.get<DifficultyComponent>();
    //
    //   if (_difficultyComponent != null) {
    //     ParallaxComponent? component =
    //         game!.world.entityManager.getEntityByName(backgroundEntity)?.get<ParallaxComponent>();
    //     if (component != null) {
    //       if (_elapsedTime > UPDATE_BACKGROUND_TIMEOUT) {
    //         _elapsedTime = 0;
    //         _currentBackground++;
    //         if (_currentBackground >= backgrounds.length) _currentBackground = 0;
    //         component.parallax?.updateLayer(0, backgrounds[_currentBackground]);
    //       } else {
    //         component.parallax?.update(delta);
    //         component.parallax?.baseVelocity = baseVelocity * _difficultyComponent!.difficulty.toDouble();
    //       }
    //     }
    //   }
    // }
    _elapsedTime += delta;

    GameStatus? status =
        game!.world.entityManager.getEntityByName(gameSessionEntity)?.get<GameStatusComponent>()?.status;

    if (status != GameStatus.dead && status != GameStatus.paused) {
      _difficultyComponent ??= game!.world.entityManager.getEntityByName(gameSessionEntity)?.get<DifficultyComponent>();

      if (_difficultyComponent != null) {
        if (_elapsedTime > UPDATE_BACKGROUND_TIMEOUT) {
          _elapsedTime = 0;
          _currentBackground++;
          if (_currentBackground >= backgrounds.length) _currentBackground = 0;
          // _backgrounds.update(delta, dt)
          _backgrounds.changeCurrentBackground();
        }
      _backgrounds.update(delta);
      }
    }
  }

  // @override
  // void renderEntity(Canvas canvas, Entity entity) => entity.get<ParallaxComponent>()?.parallax?.render(canvas);

  @override
  void init() {
    _backgrounds.resize(game!.size);
  }

  @override
  void render(Canvas canvas) {
    _backgrounds.render(canvas);
  }
}
