import 'package:meal_system_management/model/cost_details_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CostDetailsDbHelper {
  static const String createCostDetailsTable = '''CREATE TABLE $tabCostDetails(
      $tabCostDetailsColId INTEGER PRIMARY KEY,
      $tabCostDetailsColDate TEXT,
      $tabCostDetailsColBazarCost INTEGER,
      $tabCostDetailsColOtherCost INTEGER 
      )''';
  static Future<Database> openDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'meal_system.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      // When creating the db, create the table
      db.execute(createCostDetailsTable);
    });
  }
  static Future<int> insertCostData(CostDetails costMealDetails) async {
    final db=await openDB();
    return db.insert(tabCostDetails, costMealDetails.toMap());
  }
  static Future<List<CostDetails>>getAllCostDetails()async{
    final db=await openDB();
    final List<Map<String,dynamic>>mapList=await db.query(tabCostDetails);
    return List.generate(mapList.length, (index) => CostDetails.fromMap(mapList[index]));
  }
}
