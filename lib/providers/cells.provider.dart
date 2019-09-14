import 'package:flutter/material.dart';

class Cells with ChangeNotifier {
  final BuildContext context;

  Size screenSize;
  double width;
  double height;
  double rowHeight;
  double cellWidth;
  double cellHeight;
  double middleCellWidth;
  double exitCellWidth;
  List<int> cellIds = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24
  ];

  Cells(this.context) {
    screenSize = MediaQuery.of(context).size;
    width = screenSize.width - 20; // minus border
    height = screenSize.height - 19; // minus border
    rowHeight = (height - 25) / 2;
    cellWidth = width / 14;
    cellHeight = height / 2.5;
    exitCellWidth = width / 16 + 12;
    middleCellWidth = width / 16;
  }
}
