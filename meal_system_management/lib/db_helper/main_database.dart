import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/cost_details_model.dart';
import '../model/member_meal_details_model.dart';
import '../model/member_model.dart';

class DBHelper {
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

  static const String createMemberDetailsTable =
      '''CREATE TABLE $tabMemberDetails(
      $tabMemberDetailsColId INTEGER PRIMARY KEY,
      $tabMemberDetailsColName TEXT,
      $tabMemberDetailsColDate TEXT,
      $tabMemberDetailsColMeal NUM,
      $tabMemberDetailsColDeposit INTEGER 
      )''';
  static const String createCostDetailsTable = '''CREATE TABLE $tabCostDetails(
      $tabCostDetailsColId INTEGER PRIMARY KEY,
      $tabCostDetailsColDate TEXT,
      $tabCostDetailsColBazarCost INTEGER,
      $tabCostDetailsColOtherCost INTEGER 
      )''';

  //open database for all content

  static Future<Database> openDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'meal_system.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      // When creating the db, create the table
      db.execute(createAddMemberTable);
      db.execute(createMemberDetailsTable);
      db.execute(createCostDetailsTable);
    });
  }
  // base on add member model class

  static Future<int> insertData(MemberInfo memberInfo) async {
    final db = await openDB();

    return db.insert(tabMembers, memberInfo.toMap());
  }

  static Future<List<MemberInfo>> getAllMembers() async {
    final db = await openDB();
    final List<Map<String, dynamic>> mapList = await db.query(tabMembers);
    return List.generate(
        mapList.length, (index) => MemberInfo.fromMap(mapList[index]));
  }

  //Members login
  static Future<MemberInfo> getLoginMembers(
      String number, String password) async {
    final db = await openDB();
    final mapList = await db.query(
      tabMembers,
      where:
          "$tabMembersColPhone = '$number' AND $tabMembersColPassword = '$password'",
    );
    return MemberInfo.fromMap(mapList.first);
  }

  static Future<int>deleteMember(int id)async{
    final db= await openDB();
    return db.delete(tabMembers,where: '$tabMembersColId= ?',whereArgs: [id]);
  }

  static Future<MemberInfo> getMemberById(int id) async {
    final db = await openDB();
    final mapList = await db
        .query(tabMembers, where: '$tabMembersColId= ?', whereArgs: [id]);
    return MemberInfo.fromMap(mapList.first);
  }

  //base on meal details model class
  static Future<int> insertMealData(MemberMealDetails memberMealDetails) async {
    final db = await openDB();
    return db.insert(tabMemberDetails, memberMealDetails.toMap());
  }

  static Future<List<MemberMealDetails>> getAllMealMembers() async {
    final db = await openDB();
    final List<Map<String, dynamic>> mapList = await db.query(tabMemberDetails);
    return List.generate(
        mapList.length, (index) => MemberMealDetails.fromMap(mapList[index]));
  }

  static Future<List<MemberMealDetails>>getMealAndDepositByName(String name) async{
    final db=await openDB();
    final List<Map<String,dynamic>>mapList=await db.query(
        tabMemberDetails,where: '$tabMemberDetailsColName= ?',whereArgs: [name]
    );
    return List.generate(mapList.length, (index) => MemberMealDetails.fromMap(mapList[index]));// =>MemberMealDetails.fromMap(mapList.first);

  }
  static Future<int> updateMeal(int id, int value) async {
    final db = await openDB();
    return db.update(tabMemberDetails, {tabMemberDetailsColMeal: value},
        where: '$tabMemberDetailsColId= ?', whereArgs: [id]);
  }
  static Future<int>deleteMemberMeal(String name)async{
    final db= await openDB();
    return db.delete(tabMemberDetails,where: '$tabMemberDetailsColName= ?',whereArgs: [name]);
  }

  //base on cost details models class

  static Future<int> insertCostData(CostDetails costMealDetails) async {
    final db = await openDB();
    return db.insert(tabCostDetails, costMealDetails.toMap());
  }

  static Future<List<CostDetails>> getAllCostDetails() async {
    final db = await openDB();
    final List<Map<String, dynamic>> mapList = await db.query(tabCostDetails);
    return List.generate(
        mapList.length, (index) => CostDetails.fromMap(mapList[index]));
  }

  static Future<int> updateCost(int id, int bazarcost, int othercost) async {
    final db = await openDB();
    return db.update(
        tabCostDetails,
        {
          tabCostDetailsColBazarCost: bazarcost,
          tabCostDetailsColOtherCost: othercost,
        },
        where: '$tabCostDetailsColId= ?',
        whereArgs: [id]);
  }
}
