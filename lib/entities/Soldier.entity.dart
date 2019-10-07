import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class SoldierEntity {
  @required int id;
  @required Color color;
  List<int> possibleMoves = [];
  bool isMoving = false;
  bool hasMoved = false;
  bool isSelected = false;
  String cellId;
  
  SoldierEntity({this.id, this.color});
}
