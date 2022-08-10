import 'package:meal_system_management/db_helper/main_database.dart';
import 'package:meal_system_management/model/member_meal_details_model.dart';



class MemberDetailsDbHelper {

  static Future<int> insertData(MemberMealDetails memberMealDetails) async {
    final db=await DBHelper.openDB();
    return db.insert(tabMemberDetails, memberMealDetails.toMap());
  }
  static Future<List<MemberMealDetails>>getAllMembers()async{
    final db=await DBHelper.openDB();
    final List<Map<String,dynamic>>mapList=await db.query(tabMemberDetails);
    return List.generate(mapList.length, (index) => MemberMealDetails.fromMap(mapList[index]));
  }
}
