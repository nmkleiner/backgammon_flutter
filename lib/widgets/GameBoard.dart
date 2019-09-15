import 'package:backgammon/providers/Game.provider.dart';
import 'package:backgammon/widgets/ActionButtons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Cell.dart';
import 'dices/Dices.dart';
import 'CellGroup.dart';

class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final borderSide =
        BorderSide(color: Color.fromRGBO(160, 110, 44, 1), width: 10);
    final topRowBorders =
        Border(left: borderSide, top: borderSide, right: borderSide);
    final bottomRowBorders =
        Border(left: borderSide, bottom: borderSide, right: borderSide);
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(232, 214, 162, 1),
      ),
      width: double.infinity,
      child: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: CellGroup(
                    cells: gameProvider.cells.sublist(1, 14),
                    isReversed: true,
                  ),
                  decoration: BoxDecoration(border: topRowBorders),
                ),
                Cell(gameProvider.cells[0])
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: CellGroup(cells: gameProvider.cells.sublist(14, 27)),
                  decoration: BoxDecoration(border: bottomRowBorders),
                ),
                Cell(gameProvider.cells[27])
              ],
            )
          ],
        ),
        Dices(),
        ActionButtons()
      ]),
    );
  }
}
