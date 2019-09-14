import 'package:backgammon/providers/BoardConstants.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Cell.dart';
import 'dices/Dices.dart';
import 'CellGroup.dart';

class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final boardConstants = Provider.of<BoardConstants>(context);

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
                Cell(id: 0, isExitCell: true),
                CellGroup( boardConstants.cellIds.sublist(0, 6), false),
                Cell(id: 26, isMiddleCell: true),
                CellGroup( boardConstants.cellIds.sublist(6, 12), false),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Cell(id: 25, isMiddleCell: false, isExitCell: true),
                CellGroup( boardConstants.cellIds.sublist(18, 24), true),
                Cell(id: 27, isMiddleCell: true, isExitCell: false),
                CellGroup( boardConstants.cellIds.sublist(12, 18), true),
              ],
            )
          ],
        ),
        Dices(),
      ]),
    );
  }
}
