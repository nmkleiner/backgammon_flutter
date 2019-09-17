import 'package:backgammon/entities/Soldier.entity.dart';

class CellEntity {
  String id;
  bool isPossibleMove = false;
  bool isMiddleCell;
  bool isExitCell;
  List<SoldierEntity> soldiers = [];

  CellEntity(
      {this.id,
      this.isMiddleCell: false,
      this.isExitCell: false,
      });
}
