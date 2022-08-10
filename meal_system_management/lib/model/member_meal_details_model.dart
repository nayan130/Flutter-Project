class MemberMealDetails{
  int? id;
  String name;
  String date;
  int meal;
  int? deposit;

  MemberMealDetails({required this.name, required this.date, required this.meal, this.deposit,this.id});


  @override
  String toString() {
    return 'MemberMealDetails{id: $id, name: $name, date: $date, meal: $meal, deposit: $deposit}';
  }

  Map<String, dynamic> toMap(){
    return{
      tabMemberDetailsColId:id??id,
      tabMemberDetailsColName:name,
      tabMemberDetailsColDate:date,
      tabMemberDetailsColMeal:meal,
      tabMemberDetailsColDeposit:deposit


    };

  }
  factory MemberMealDetails.fromMap(Map<String,dynamic>map){
    return  MemberMealDetails(
        id: map[tabMemberDetailsColId],
        name: map[tabMemberDetailsColName],
        date: map[tabMemberDetailsColDate],
        meal: map[tabMemberDetailsColMeal],

        deposit: map[tabMemberDetailsColDeposit]

    );
  }
}
const String tabMemberDetails='tb_meal_details';
const String tabMemberDetailsColId='id';
const String tabMemberDetailsColName='name';
const String tabMemberDetailsColDate='date';
const String tabMemberDetailsColMeal='meal';
const String tabMemberDetailsColDeposit='deposit';
