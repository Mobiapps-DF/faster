import 'package:easy_localization/easy_localization.dart';
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text(tr('labels.deadPlayer')), Text(tr('actions.retry'))])),
    );
  }
}
