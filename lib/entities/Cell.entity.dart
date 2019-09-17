import 'package:backgammon/entities/Soldier.entity.dart';
import 'package:flutter/material.dart';

class CellEntity {
  String id;
  bool isPossibleMove = false;
  bool isMiddleCell;
  bool isExitCell;
  List<SoldierEntity> soldiers = [];

  CellEntity({
    this.id,
    this.isMiddleCell: false,
    this.isExitCell: false,
  });

  bool isHouseOf(Color color) {
    return (soldiers.length > 1) && (soldiers[1].color == color);
  }
}
