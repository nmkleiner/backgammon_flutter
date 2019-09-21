import 'package:backgammon/entities/Cell.entity.dart';
import 'package:flutter/material.dart';

import 'Cell.dart';

class CellGroup extends StatelessWidget {
  final List<CellEntity> cells;
  final bool isReversed;

  CellGroup({this.cells, this.isReversed: false});

  @override
  Widget build(BuildContext context) {
    print('cellGroup build');
    return Row(
        children: isReversed
            ? <Widget>[...cells.map((cell) => Cell(cell)).toList().reversed]
            : <Widget>[...cells.map((cell) => Cell(cell)).toList()]);
  }
}
