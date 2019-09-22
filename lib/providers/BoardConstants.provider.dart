import 'package:flutter/material.dart';

class BoardConstants with ChangeNotifier {
  final BuildContext context;

  Size screenSize;
  double width;
  double height;
  double rowHeight;
  double cellWidth;
  double cellHeight;
  double middleCellWidth;
  double exitCellWidth;
  double rowWidth;
  double actionButtonLeft;
  double actionButtonTop;
  double soldierRadius;
  double borderWidth;

  BoardConstants(this.context) {
    screenSize = MediaQuery.of(context).size;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      width = screenSize.height;
      height = screenSize.width;
    } else {
      width = screenSize.width; // minus border
      height = screenSize.height; // minus border
    }

    rowHeight = height / 2.31;
    cellHeight = rowHeight * 0.8;
    actionButtonTop = rowHeight - 13;
    soldierRadius = cellHeight / 10;

    borderWidth = soldierRadius;
    middleCellWidth = soldierRadius * 2;
    cellWidth = (width - 2 * borderWidth) / 13.5;
    exitCellWidth = (width - 2 * borderWidth) / 16;
    rowWidth = (width - middleCellWidth - exitCellWidth - 2 * borderWidth) / 2;
    actionButtonLeft = rowWidth * 1.4 + middleCellWidth - 5;
  }
}
