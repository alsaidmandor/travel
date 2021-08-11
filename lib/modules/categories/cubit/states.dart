abstract class CategoryStates {}

class CategoryInitialState extends CategoryStates {}

class CategoryChangeIndexList extends CategoryStates {
  int? index;

  CategoryChangeIndexList({this.index});
}
