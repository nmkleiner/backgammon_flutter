import 'package:flutter/material.dart';

import 'ExitCell.dart';
import 'MiddleCell.dart';
import 'TriangleCell.dart';

class Cell extends StatelessWidget {
  final int id;
  final bool isMiddleCell;
  final bool isExitCell;

  Cell({this.id, this.isMiddleCell, this.isExitCell});

  @override
  Widget build(BuildContext context) {
    if (isMiddleCell) {
      return  MiddleCell(
          id: id);
    } else if (isExitCell) {
      return  ExitCell(
          id: id);
    }
    else {
      return TriangleCell(
          id: id,
          isRotated: id > 12);
    }
  }
}
