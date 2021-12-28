import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

typedef OnPressCallback = void Function();

class FasterHome extends StatelessWidget {
  static String name = 'faster_home';

  final OnPressCallback onPressed;

  const FasterHome(this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/images/faster.png'),
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
            onTap: onPressed,
          )
        ],
      ),
    );
  }
}
