import 'package:easy_localization/easy_localization.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/layers/faster_dead_layer.dart';
import 'package:faster/layers/faster_home_layer.dart';
import 'package:faster/utils/game_status_helper.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('fr', 'FR')],
    path: 'assets/i18n',
    fallbackLocale: const Locale('en', 'US'),
    useOnlyLangCode: true,
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'RoadRage'),
      home: Scaffold(
        body: GameWidget(
          game: FasterGame(),
          overlayBuilderMap: {
            FasterHome.name: (BuildContext context, FasterGame game) {
              return FasterHome(() => setPlaying(game));
            },
            FasterDead.name: (BuildContext context, FasterGame game) {
              return FasterDead(() => setPlaying(game));
            },
          },
          initialActiveOverlays: [
            FasterHome.name,
          ],
        ),
      ),
    );
  }
}
