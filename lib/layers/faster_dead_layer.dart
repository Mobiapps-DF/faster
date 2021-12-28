import 'package:flutter/material.dart';

typedef OnPressCallback = void Function();

class FasterDead extends StatelessWidget {
  static String name = 'faster_dead';

  final OnPressCallback onPressed;

  const FasterDead(this.onPressed, {Key? key}) : super(key: key);

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
                width: 400,
                height: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/dead.png'), fit: BoxFit.contain),
                )),
          ))
    );
  }
}
