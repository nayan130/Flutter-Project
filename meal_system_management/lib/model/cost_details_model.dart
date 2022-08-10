class CostDetails {
  int? id;
  int? bazarcost;
  String? date;
  int? othercost;

  CostDetails({this.id, this.bazarcost, this.date, this.othercost});

  @override
  String toString() {
    return 'CostMealDetails{id: $id, bazarcost: $bazarcost, date: $date, othercost: $othercost}';
  }

  Map<String, dynamic> toMap() {
    return {
      tabCostDetailsColId: id ?? id,
      tabCostDetailsColDate: date,
      tabCostDetailsColBazarCost: bazarcost,
      tabCostDetailsColOtherCost: othercost
    };
  }

  factory CostDetails.fromMap(Map<String, dynamic> map) {
    return CostDetails(
        id: map[tabCostDetailsColId],
        date: map[tabCostDetailsColDate],
        bazarcost: map[tabCostDetailsColBazarCost],
        othercost: map[tabCostDetailsColOtherCost]);
  }
}

const String tabCostDetails = 'tb_cost_details';
const String tabCostDetailsColId = 'id';
const String tabCostDetailsColDate = 'date';
const String tabCostDetailsColBazarCost = 'bazarcost';
const String tabCostDetailsColOtherCost = 'othercost';
