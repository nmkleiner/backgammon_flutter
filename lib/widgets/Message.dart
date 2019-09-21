import 'package:backgammon/providers/Game.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Message extends StatelessWidget {
  Message();

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    if (gameProvider.isTurkishMars) return Text('TurkishMars!!!');
    else if (gameProvider.isMars) return Text('Mars!!');
    else return Text('player Won!');
  }
}