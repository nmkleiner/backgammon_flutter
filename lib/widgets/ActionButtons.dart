import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:backgammon/providers/Game.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'NiceButton.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final boardConstants = Provider.of<BoardConstants>(context);
    final gameProvider = Provider.of<GameProvider>(context);

    Widget buttonToShow() {
      if (gameProvider.showDicesButton) {
        return NiceButton(
            onPressed: gameProvider.rollDices, text: 'Roll Dices');
      } else {
        return null;
      }
    }

    return Container(
        margin: EdgeInsets.fromLTRB(boardConstants.actionButtonLeft,
            boardConstants.actionButtonTop, 0, 0),
        child: buttonToShow());
  }
}
