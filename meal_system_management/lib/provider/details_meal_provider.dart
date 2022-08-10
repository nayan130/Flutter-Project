import 'package:flutter/material.dart';
import 'package:meal_system_management/model/member_meal_details_model.dart';

import '../db_helper/main_database.dart';

class DetailsMealProvider extends ChangeNotifier {
  List<MemberMealDetails> mealDetailsMember = [];
  List<MemberMealDetails> mealAndDepositByName = [];

  Future<bool> addMealDetails(MemberMealDetails memberMealDetails) async {
    final rowId = await DBHelper.insertMealData(memberMealDetails);
    if (rowId > 0) {
      memberMealDetails.id = rowId;
      mealDetailsMember.add(memberMealDetails);
      getAllMeals();
      notifyListeners();
      return true;
    }
    return false;
  }

  getAllDetailsMember() async {
    mealDetailsMember = await DBHelper.getAllMealMembers();
    getAllMeals();
    notifyListeners();
  }

  int totalMeals = 0;
  int totalDeposit = 0;

  getAllMeals() {
    totalMeals = 0;
    totalDeposit = 0;
    mealDetailsMember.forEach((element) {
      totalMeals += element.meal;
      totalDeposit += element.deposit!;
    });
    // notifyListeners();
  }

  Future<bool> getMealsAndDepositByName(String name) async {
    mealAndDepositByName = await DBHelper.getMealAndDepositByName(name);
    getTotalMealsAndDepositByName();
    notifyListeners();
    return true;
  }

  int totalPersonMeals = 0;
  int totalPersonDeposit = 0;

  getTotalMealsAndDepositByName() {
    totalPersonMeals = 0;
    totalPersonDeposit = 0;
    for (var element in mealAndDepositByName) {
      totalPersonMeals += element.meal;
      totalPersonDeposit += element.deposit!;
    }
    // notifyListeners();
  }

  Future<int> updateMealDetails(int id, int value) async {
    final rowId = await DBHelper.updateMeal(id, value);
    if (rowId > 0) {
      //contactList[index].favourite = !contactList[index].favourite;
      mealDetailsMember[id - 1].meal = value;
      getAllMeals();
      notifyListeners();
      // return rowId;

    }
    return rowId;
  }

  deleteMemberMeal(String name) async {
    final rowId = await DBHelper.deleteMemberMeal(name);
    if (rowId > 0) {
      mealDetailsMember.removeWhere((element) => element.name == name);
      notifyListeners();
    }
  }
  //  updateMealDetails(int id, int value) async {
  //   final rowId = await DBHelper.updateMeal(id, value);
  //   if (rowId > 0) {
  //     //contactList[index].favourite = !contactList[index].favourite;
  //     mealDetailsMember[id].meal = value;
  //     notifyListeners();
  //
  //   }}
  //return rowId;
  //notifyListeners();

}
