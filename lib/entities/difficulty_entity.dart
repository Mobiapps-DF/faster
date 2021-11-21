import 'package:faster/components/difficulty_component.dart';
import 'package:faster/faster_game.dart';
import 'package:flame_oxygen/flame_oxygen.dart';

Entity createDifficulty(FasterGame game) => game.world.createEntity('Difficulty')..add<DifficultyComponent, int>(1);
