
import 'package:flutter/cupertino.dart';

typedef OnPressCallBack = void Function();

class FasterCredits extends StatelessWidget {

  static String name = "faster_credits";
  final OnPressCallBack onPressed;

  const FasterCredits(this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     child:  SizedBox(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             Container(
               margin: const EdgeInsets.all(25),
               child: const Text(
                   'Remerciements'
               ),
             )
           ],
         )
     ),
     onTap: onPressed,
   );
  }

}