import 'package:easy_localization/easy_localization.dart';
import 'package:faster/utils/colors.dart';
import 'package:flutter/cupertino.dart';
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 400,
                      height: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/dead.png'), fit: BoxFit.contain),
                      )),
                  Text(
                    tr('actions.retry'),
                    style: const TextStyle(fontSize: 36, color: appLightBlue),
                  )
                ],
              ),
            )));
  }
}
