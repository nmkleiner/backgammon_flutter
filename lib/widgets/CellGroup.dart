import 'package:flutter/material.dart';

import 'Cell.dart';

class CellGroup extends StatelessWidget {
  final List<int> cells;
  final bool isReversed;

  CellGroup(this.cells, this.isReversed);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: isReversed
            ? <Widget>[
                ...cells
                    .map((cellId) => Cell(id: cellId, isMiddleCell: false, isExitCell: false))
                    .toList()
                    .reversed
              ]
            : <Widget>[
                ...cells
                    .map((cellId) => Cell(id: cellId, isMiddleCell: false, isExitCell: false,))
                    .toList()
              ]);
  }
}
