import 'package:backgammon/entities/CellEntity.dart';
import 'package:flutter/material.dart';

import 'ExitCell.dart';
import 'MiddleCell.dart';
import 'TriangleCell.dart';

class Cell extends StatelessWidget {
  final CellEntity cell;

  Cell(this.cell);

  @override
  Widget build(BuildContext context) {
    if (cell.isMiddleCell) {
      return MiddleCell(id: cell.id);
    } else if (cell.isExitCell) {
      return ExitCell(id: cell.id);
    } else {
      return TriangleCell(id: cell.id, isRotated: cell.id > 12);
    }
  }
}
