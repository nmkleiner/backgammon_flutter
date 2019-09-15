import 'package:backgammon/entities/CellEntity.dart';
import 'package:flutter/material.dart';

import 'Cell.dart';

class CellGroup extends StatelessWidget {
  final List<CellEntity> cells;
  final bool isReversed;

  CellGroup(this.cells, this.isReversed);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: isReversed
            ? <Widget>[
                ...cells
                    .map((cell) => Cell(id: cell.id))
                    .toList()
                    .reversed
              ]
            : <Widget>[
                ...cells
                    .map((cell) => Cell(id: cell.id))
                    .toList()
              ]);
  }
}
