import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnPressCallBack = void Function();

class FasterCredits extends StatefulWidget {
  static String name = "faster_credits";

  final OnPressCallBack onPressed;

  const FasterCredits(this.onPressed, {Key? key}) : super(key: key);

  @override
  State<FasterCredits> createState() => _FasterCreditState();
}

class _FasterCreditState extends State<FasterCredits> {

  void _returnHome() {
    setState(() {
      widget.onPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(tr('labels.thanks'),
                      style: const TextStyle(fontSize: 22.0)),
                  Text(tr('labels.guillaume'),
                      style: const TextStyle(fontSize: 18.0)),
                  Text(tr('labels.simon'),
                      style: const TextStyle(fontSize: 18.0)),
                  Text(tr('labels.samuel'),
                      style: const TextStyle(fontSize: 18.0)),
                  Text(tr('labels.maxime'),
                      style: const TextStyle(fontSize: 18.0)),
                  Text(tr('labels.lamine'),
                      style: const TextStyle(fontSize: 18.0)),
                  const SizedBox(height: 10),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(tr('labels.made'),
                      style: const TextStyle(fontSize: 18.0)),
                  Image.asset('assets/images/flame_img.png',
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 4),
                  const Text('https://www.kenney.nl/assets',
                      style: TextStyle(fontSize: 18.0)),
                  Image.asset('assets/images/logo_kga.png',
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 4),
                ],
              ),
            ],
          )),
      onTap: () {
        _returnHome();
      },
    );
  }
}
