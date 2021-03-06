import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String highScoreKey = 'HIGH_SCORE';

class UserPreferences extends ChangeNotifier {
  double? _highScore;
  double? _lastScore;

  UserPreferences() {
    _loadHighScore().then((value) => highScore = value);
  }

  double get highScore => _highScore ?? 0;

  set highScore(double score) {
    if (score > highScore) {
      _saveHighScore(score);
      _highScore = score;
      notifyListeners();
    }
  }

  double get lastScore => _lastScore ?? 0;

  set lastScore(double score) => _lastScore = score;

  Future<double> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(highScoreKey) ?? 0.0;
  }

  Future<void> _saveHighScore(double score) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(highScoreKey, score);
  }
}
