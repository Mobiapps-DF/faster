import 'package:easy_localization/easy_localization.dart';
import 'package:faster/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef OnPressCallback = void Function();

class FasterHome extends StatelessWidget {
  static String name = 'faster_home';

  final OnPressCallback onCreditsPressed;
  final OnPressCallback onPlayPressed;

  const FasterHome(this.onCreditsPressed,this.onPlayPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final highScore = Provider.of<UserPreferences>(context).highScore;
    
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.all(25),
            child: TextButton(
              child: Text(
                tr('labels.credits'),
                style: const TextStyle(
                    fontSize: 22.0
                ),
              ),
              onPressed: onCreditsPressed,
            ),
          ),
          Image.asset('assets/images/faster.png'),
          Text(
            '${tr('labels.highScore')}: ${highScore.round()}',
            style: const TextStyle(
              fontSize: 32,
            ),
          ),
          GestureDetector(
            child: Container(
              width: 190,
              height: 60,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/button.png'), fit: BoxFit.fill),
              ),
              child: Center(
                child: Text(
                  tr('actions.play'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48
                  ),
                ),
              ),
            ),
            onTap: onPlayPressed,
          )
        ],
      ),
    );
  }
}
