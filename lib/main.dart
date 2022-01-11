import 'package:easy_localization/easy_localization.dart';
import 'package:faster/components/game_status_component.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/layers/faster_dead_layer.dart';
import 'package:faster/layers/faster_home_layer.dart';
import 'package:faster/layers/faster_paused_layer.dart';
import 'package:faster/layers/faster_playing_layer.dart';
import 'package:faster/utils/game_status_helper.dart';
import 'package:faster/utils/user_preferences.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final highScore = await getHighScore();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('fr', 'FR')],
    path: 'assets/i18n',
    fallbackLocale: const Locale('en', 'US'),
    useOnlyLangCode: true,
    child: App(highScore: highScore,),
  ));
}

class App extends StatefulWidget {
  final double highScore;

  const App({required this.highScore, Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  FasterGame? _game;

  @override
  void initState() {
    super.initState();
    _game = FasterGame();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appState) {
    GameStatus? gameStatus = getGameStatus(_game!);
    if (gameStatus != null) {
      switch (appState) {
        case AppLifecycleState.resumed:
          /// do nothing
          break;
        case AppLifecycleState.inactive:
        case AppLifecycleState.paused:
        case AppLifecycleState.detached:
          if (gameStatus == GameStatus.playing) setPaused(_game!);
          break;
      }
    }
  }

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
          game: _game!,
          overlayBuilderMap: {
            FasterHome.name: (BuildContext context, FasterGame game) {
              return FasterHome(() => setPlaying(game), highScore: widget.highScore,);
            },
            FasterPlaying.name: (BuildContext context, FasterGame game) {
              return FasterPlaying(() => setPaused(game));
            },
            FasterPaused.name: (BuildContext context, FasterGame game) {
              return FasterPaused(() => unsetPause(game));
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
