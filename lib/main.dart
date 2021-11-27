import 'package:faster/faster_game.dart';
import 'package:faster/layers/faster_home.dart';
import 'package:faster/utils/game_status_helper.dart';
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
            return FasterHome(() => setPlaying(game));
          }
        },
        initialActiveOverlays: [
          FasterHome.name,
        ],
      ),
    ),
  ));
}
