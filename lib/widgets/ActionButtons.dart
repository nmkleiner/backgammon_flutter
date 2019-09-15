import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:backgammon/providers/Dices.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'NiceButton.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final boardConstants = Provider.of<BoardConstants>(context);
    final dicesProvider = Provider.of<DicesProvider>(context);

    return Container(
        margin: EdgeInsets.fromLTRB(
            boardConstants.actionButtonLeft, 
            boardConstants.actionButtonTop, 0, 0),
        child: NiceButton(
            onPressed: dicesProvider.rotateDices, text: 'Roll Dices'));
  }
}
