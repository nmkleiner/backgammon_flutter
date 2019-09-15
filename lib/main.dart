import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:backgammon/providers/Game.provider.dart';
import 'package:backgammon/providers/Dices.provider.dart';
import 'package:provider/provider.dart';
import 'package:backgammon/widgets/GameBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backgammon',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            PreferredSize(child: AppBar(), preferredSize: Size.fromHeight(0)),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<BoardConstants>(
                builder: (_) => BoardConstants(context)),
            ChangeNotifierProvider<DicesProvider>(
                builder: (_) => DicesProvider()),
            ChangeNotifierProvider<GameProvider>(
              builder: (_) => GameProvider(),
            )
          ],
          child: GameBoard(),
        ));
  }
}
