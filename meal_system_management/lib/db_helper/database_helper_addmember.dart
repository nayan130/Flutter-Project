import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/member_model.dart';

class AddMemberDbHelper {
  static const String createAddMemberTable = '''CREATE TABLE $tabMembers(
      $tabMembersColId INTEGER PRIMARY KEY,
      $tabMembersColName TEXT,
      $tabMembersColPhone TEXT,
      $tabMembersColPassword TEXT,
      $tabMembersColImage TEXT,
      $tabMembersColMemberType TEXT,
      $tabMembersColMeal NUM,
      $tabMembersColMealRate NUM,
      $tabMembersColDeposit INTEGER 
      )''';
  static Future<Database> openDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'meal_system.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      // When creating the db, create the table
      db.execute(createAddMemberTable);
    });
  }
  static Future<int> insertData(MemberInfo memberInfo) async {
      final db=await openDB();

      return db.insert(tabMembers, memberInfo.toMap());
  }
  static Future<List<MemberInfo>>getAllMembers()async{
      final db=await openDB();
      final List<Map<String,dynamic>>mapList=await db.query(tabMembers);
      return List.generate(mapList.length, (index) => MemberInfo.fromMap(mapList[index]));
  }
// deleteContact(int id) async{
//   final rowId = await DBHelper.deleteContact(id);
//   if(rowId>0){
//     contactList.removeWhere((element) => element.id==id);
//     notifyListeners();
//   }
// }
}
