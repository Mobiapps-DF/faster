import 'package:flutter/material.dart';

typedef OnPressCallback = void Function();

class FasterPaused extends StatelessWidget {
  static String name = 'faster_paused';

  final OnPressCallback onPressed;

  const FasterPaused(this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onPressed();
        },
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Container(
                    width: 190,
                    height: 60,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/paused.png'), fit: BoxFit.contain),
                    )))));
  }
}
