import 'package:faster/components/game_status_component.dart';
import 'package:faster/entities/game_session_entity.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/widgets/faster_home.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: GameWidget(
        game: FasterGame(),
        overlayBuilderMap: {
          FasterHome.name: (BuildContext context, FasterGame game) {
            return FasterHome(() {
              game.world.entityManager.getEntityByName(gameSessionEntity)?.get<GameStatusComponent>()?.status =
                  GameStatus.playing;
            });
          }
        },
        initialActiveOverlays: [
          FasterHome.name,
        ],
      ),
    ),
  ));
}
