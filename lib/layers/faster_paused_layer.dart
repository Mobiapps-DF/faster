import 'package:easy_localization/easy_localization.dart';
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
              child: Text(tr('labels.paused')))),
    );
  }
}
