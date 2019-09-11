import 'package:flutter/material.dart';
import 'package:backgammon/providers/cells.provider.dart';
import 'package:provider/provider.dart';
import 'Cell.dart';
import 'CellGroup.dart';

class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cells = Provider.of<Cells>(context);

    return Container(
      color: Color.fromRGBO(232, 214, 162, 1),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Cell(id: 0, isMiddleCell: false, isExitCell: true),
              CellGroup(cells.cellIds.sublist(0, 6), false),
              Cell(id: 26, isMiddleCell: true, isExitCell: false),
              CellGroup(cells.cellIds.sublist(6, 12), false),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Cell(id: 25, isMiddleCell: false, isExitCell: true),
              CellGroup(cells.cellIds.sublist(18, 24), true),
              Cell(id: 27, isMiddleCell: true, isExitCell: false),
              CellGroup(cells.cellIds.sublist(12, 18), true),
            ],
          )
        ],
      ),
    );
  }
}
