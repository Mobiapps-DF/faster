import 'package:shared_preferences/shared_preferences.dart';

const String highScoreKey = 'HIGH_SCORE';

Future<void> saveHighScore(double highScore) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setDouble(highScoreKey, highScore);
}

Future<double> getHighScore() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getDouble(highScoreKey) ?? 0.0;
}
