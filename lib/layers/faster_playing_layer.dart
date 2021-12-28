import 'package:flutter/material.dart';

typedef OnPauseCallback = void Function();

class FasterPlaying extends StatelessWidget {
  static String name = 'faster_playing';

  final OnPauseCallback onPaused;

  const FasterPlaying(this.onPaused, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        right: 0,
        child: IconButton(
          icon: const ImageIcon(AssetImage("assets/images/pause.png"), color: Color(0xff1ea7e1)),
          onPressed: () => onPaused(),
        ),
      )
    ]);
  }
}
