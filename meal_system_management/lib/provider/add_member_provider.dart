import 'package:flutter/material.dart';
import 'package:meal_system_management/db_helper/main_database.dart';
import '../model/member_model.dart';

class AddMemberProvider extends ChangeNotifier {
List<MemberInfo> allMembers = [];

  Future<bool> addNewMembers(MemberInfo memberInfo) async {
    final rowId = await DBHelper.insertData(memberInfo);
    if (rowId > 0) {
      memberInfo.id = rowId;
      allMembers.add(memberInfo);
      notifyListeners();
      return true;
    }
    return false;
  }

  getAllMembers() async {
    allMembers = await DBHelper.getAllMembers();
    notifyListeners();
  }
Future<MemberInfo>getMemberDetailsById(int id)=>DBHelper.getMemberById(id);

deleteMember(int id) async{
  final rowId = await DBHelper.deleteMember(id);
  if(rowId>0){
    allMembers.removeWhere((element) => element.id==id);
    notifyListeners();
  }
}

}
