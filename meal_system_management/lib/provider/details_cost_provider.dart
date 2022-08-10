import 'package:flutter/material.dart';
import 'package:meal_system_management/db_helper/main_database.dart';
import '../model/cost_details_model.dart';

class DetailsCostProvider extends ChangeNotifier {
  List<CostDetails> allCostMembers = [];

  Future<bool>allCostDetails(CostDetails costDetails) async {
    final rowId = await DBHelper.insertCostData(costDetails);
    if (rowId > 0) {
      costDetails.id = rowId;
      allCostMembers.add(costDetails);
      getPerCost();
      notifyListeners();
      return true;
    }
    return false;
  }

  getAllCost() async {
    allCostMembers = await DBHelper.getAllCostDetails();
    getPerCost();
    notifyListeners();
  }

  int totalBazarCost=0;
  int totalOtherCost=0;


  getPerCost(){
    allCostMembers.forEach((element) {
      totalBazarCost+=element.bazarcost!;
      totalOtherCost+=element.othercost!;
    });

  }
  Future<int> updateCostDetails(int id, int bazarcost, int othercost) async {
    final rowId = await DBHelper.updateCost(id, bazarcost, othercost);

    if (rowId > 0) {
      //contactList[index].favourite = !contactList[index].favourite;
      allCostMembers[id-1].bazarcost = bazarcost;
      allCostMembers[id-1].othercost = othercost;
      getPerCost();
      notifyListeners();
      // return rowId;

    }
    return rowId;
    //notifyListeners();
  }
}
