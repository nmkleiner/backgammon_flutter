class CellEntity {
  int id;
  bool whiteHouse;
  bool blackHouse;
  bool isPossibleMove = false;
  bool isMiddleCell;
  bool isExitCell;

  CellEntity(
      {this.id,
      this.whiteHouse: false,
      this.blackHouse: false,
      this.isMiddleCell: false,
      this.isExitCell: false});
}
