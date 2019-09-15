import 'package:backgammon/entities/CellEntity.dart';
import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  List<CellEntity> cells = [
    CellEntity(id: 0, isExitCell: true),
    CellEntity(id: 1, whiteHouse: true),
    CellEntity(id: 2),
    CellEntity(id: 3),
    CellEntity(id: 4),
    CellEntity(id: 5),
    CellEntity(id: 6, blackHouse: true),
    CellEntity(id: 26, isMiddleCell: true),
    CellEntity(id: 7),
    CellEntity(id: 8, blackHouse: true),
    CellEntity(id: 9),
    CellEntity(id: 10),
    CellEntity(id: 11),
    CellEntity(id: 12, whiteHouse: true),
    CellEntity(id: 13, blackHouse: true),
    CellEntity(id: 14),
    CellEntity(id: 15),
    CellEntity(id: 16, whiteHouse: true),
    CellEntity(id: 17),
    CellEntity(id: 18, whiteHouse: true),
    CellEntity(id: 27, isMiddleCell: true),
    CellEntity(id: 19),
    CellEntity(id: 20),
    CellEntity(id: 21),
    CellEntity(id: 22),
    CellEntity(id: 23),
    CellEntity(id: 24, blackHouse: true),
    CellEntity(id: 25, isExitCell: true)
  ];
}
