import 'package:backgammon/entities/Soldier.entity.dart';

class CellEntity {
  String id;
  bool whiteHouse;
  bool blackHouse;
  bool isPossibleMove = false;
  bool isMiddleCell;
  bool isExitCell;
  List<SoldierEntity> soldiers = [];

  CellEntity(
      {this.id,
      this.whiteHouse: false,
      this.blackHouse: false,
      this.isMiddleCell: false,
      this.isExitCell: false,
      this.soldiers
      });
}
