import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final fasterGame = FasterGame();

  runApp(GameWidget(game: fasterGame));
}

class FasterGame extends FlameGame {
  FasterGame();
}
