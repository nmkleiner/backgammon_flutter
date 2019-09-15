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
  

  BoardConstants(this.context) {
    screenSize = MediaQuery.of(context).size;
    width = screenSize.width - 20; // minus border
    height = screenSize.height - 19; // minus border
    rowHeight = (height - 25) / 2;
    cellWidth = width / 14;
    cellHeight = height / 2.5;
    exitCellWidth = width / 16 + 12;
    middleCellWidth = width / 16;
    rowWidth = (width - middleCellWidth - exitCellWidth - 20) / 2;
    actionButtonLeft = rowWidth * 1.4 + middleCellWidth - 5;
    actionButtonTop = rowHeight - 13;
  }
}
