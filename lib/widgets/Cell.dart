import 'package:backgammon/entities/Cell.entity.dart';
import 'package:flutter/material.dart';

import 'ExitCell.dart';
import 'MiddleCell.dart';
import 'TriangleCell.dart';

class Cell extends StatelessWidget {
  final CellEntity cell;

  Cell(this.cell);

  Widget get cellType {
    if (cell.isMiddleCell) {
      return MiddleCell(
          id: cell.id,
          isRotated: cell.id == 'whiteMiddleCell',
          soldiers: cell.soldiers);
    } else if (cell.isExitCell) {
      return ExitCell(
          id: cell.id,
          isRotated: cell.id == 'whiteExitCell',
          soldiers: cell.soldiers);
    } else {
      return TriangleCell(
          id: cell.id,
          isRotated: int.parse(cell.id) > 12,
          soldiers: cell.soldiers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: cellType,
      onTap: () {
        print(cell.id);
      },
    );
  }
}
