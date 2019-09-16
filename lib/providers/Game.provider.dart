import 'package:backgammon/entities/Cell.entity.dart';
import 'package:backgammon/entities/Soldier.entity.dart';
import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  List<CellEntity> cells = [
    CellEntity(id: 'blackExitCell', isExitCell: true),
    CellEntity(id: '1', whiteHouse: true),
    CellEntity(id: '2'),
    CellEntity(id: '3'),
    CellEntity(id: '4'),
    CellEntity(id: '5'),
    CellEntity(id: '6', blackHouse: true),
    CellEntity(id: 'blackMiddleCell', isMiddleCell: true),
    CellEntity(id: '7'),
    CellEntity(id: '8', blackHouse: true),
    CellEntity(id: '9'),
    CellEntity(id: '10'),
    CellEntity(id: '11'),
    CellEntity(id: '12', whiteHouse: true),
    CellEntity(id: '13', blackHouse: true),
    CellEntity(id: '14'),
    CellEntity(id: '15'),
    CellEntity(id: '16', whiteHouse: true),
    CellEntity(id: '17'),
    CellEntity(id: '18', whiteHouse: true),
    CellEntity(id: 'whiteMiddleCell', isMiddleCell: true),
    CellEntity(id: '19'),
    CellEntity(id: '20'),
    CellEntity(id: '21'),
    CellEntity(id: '22'),
    CellEntity(id: '23'),
    CellEntity(id: '24', blackHouse: true),
    CellEntity(id: 'whiteExitCell', isExitCell: true)
  ];

  Map<String, Map<String, dynamic>> boardMap = {
    '1': {'amount': 2, 'color': Colors.white},
    '6': {'amount': 5, 'color': Colors.black},
    '9': {'amount': 3, 'color': Colors.black},
    '13': {'amount': 5, 'color': Colors.white},
    '14': {'amount': 5, 'color': Colors.black},
    '18': {'amount': 3, 'color': Colors.white},
    '21': {'amount': 5, 'color': Colors.white},
    '26': {'amount': 2, 'color': Colors.black},
  };

  GameProvider() {
    _setBoard();
  }

  void _setBoard() {
    boardMap.forEach((String cellId,Map value) {
      List<SoldierEntity> soldiers = _createSoldiers(boardMap[cellId]['amount'], boardMap[cellId]['color']).toList();
      soldiers.forEach((soldier) {
        cells[int.parse(cellId)].soldiers.add(soldier);
      });
    });
  }

  int soldierId = 0;
  List<SoldierEntity> _createSoldiers(int amount, Color color) {
    List<SoldierEntity> res = [];
    for (var i = 0; i < amount; i++) {
        res.add(SoldierEntity(color: color, id: soldierId++));
    }
    return res;
  }

  
}
