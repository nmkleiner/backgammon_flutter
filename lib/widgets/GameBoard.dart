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

    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(232, 214, 162, 1),
          border: Border.all(
            color: Color.fromRGBO(160, 110, 44, 1),
            width: 10,
          )),
      width: double.infinity,
      child: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CellGroup(cells: gameProvider.cells.sublist(8, 14), isReversed: true),
                Cell(gameProvider.cells[7]),
                CellGroup(cells: gameProvider.cells.sublist(1, 7), isReversed: true),
                Cell(gameProvider.cells[0]),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                CellGroup(cells: gameProvider.cells.sublist(14, 20)),
                Cell(gameProvider.cells[20]),
                CellGroup(cells: gameProvider.cells.sublist(21, 27)),
                Cell(gameProvider.cells[27]),
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
