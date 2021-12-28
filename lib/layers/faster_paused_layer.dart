import 'dart:async';

import 'package:flutter/material.dart';

typedef OnPressCallback = void Function();

const tickerLength = 3;

class FasterPaused extends StatefulWidget {
  static String name = 'faster_paused';

  final OnPressCallback onPressed;

  const FasterPaused(this.onPressed, {Key? key}) : super(key: key);

  @override
  State<FasterPaused> createState() => _FasterPausedState();
}

class _FasterPausedState extends State<FasterPaused> {
  Timer? _timer;
  int _ticker = 3;
  bool _restarting = false;

  void _startTicker() {
    setState(() {
      _restarting = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        --_ticker;
      });
      if (_ticker < 1) widget.onPressed();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _startTicker();
        },
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _restarting
                ? Center(
                    child: Text(
                    _ticker.toString(),
                    style: const TextStyle(fontSize: 48, color: Color(0xff1ea7e1)),
                  ))
                : const Center(child: _Paused())));
  }
}

class _Paused extends StatelessWidget {
  const _Paused({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 190,
        height: 60,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/paused.png'), fit: BoxFit.contain),
        ));
  }
}
