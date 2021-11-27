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
      child: Center(
        child: OutlinedButton(
          child: Text('PLAY'),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
