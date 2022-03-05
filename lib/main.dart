import 'package:easy_localization/easy_localization.dart';
import 'package:faster/components/game_status_component.dart';
import 'package:faster/faster_game.dart';
import 'package:faster/layers/faster_credits_layer.dart';
import 'package:faster/layers/faster_dead_layer.dart';
import 'package:faster/layers/faster_home_layer.dart';
import 'package:faster/layers/faster_paused_layer.dart';
import 'package:faster/layers/faster_playing_layer.dart';
import 'package:faster/utils/game_status_helper.dart';
import 'package:faster/utils/user_preferences.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('fr', 'FR')],
    path: 'assets/i18n',
    fallbackLocale: const Locale('en', 'US'),
    useOnlyLangCode: true,
    child: ChangeNotifierProvider(
      create: (_) => UserPreferences(),
      child: const App(),
    ),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  FasterGame? _game;

  @override
  void initState() {
    super.initState();
    _game = FasterGame(saveScore: _saveScore);
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

  void _saveScore(double score) => Provider.of<UserPreferences>(context, listen: false)
    ..highScore = score
    ..lastScore = score;

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
              return FasterHome(() {
                setCredits(game);
              }, () {
                FlameAudio.play('click.mp3');
                setPlaying(game);
              });
            },
            FasterCredits.name: (BuildContext context, FasterGame game) {
              return FasterCredits(() {
                setHome(game);
              });
            },
            FasterPlaying.name: (BuildContext context, FasterGame game) {
              return FasterPlaying(() {
                FlameAudio.play('click.mp3');
                setPaused(game);
              });
            },
            FasterPaused.name: (BuildContext context, FasterGame game) {
              return FasterPaused(() {
                FlameAudio.play('click.mp3');
                unsetPause(game);
              });
            },
            FasterDead.name: (BuildContext context, FasterGame game) {
              return FasterDead(() {
                FlameAudio.play('click.mp3');
                setPlaying(game);
              });
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
