class MemberInfo{
  int? id;
  String name;
  String phone;
  String password;
  String?image;
 String? membertype;
  int? meal;
  int? mealrate;
  int? deposit;

  MemberInfo(
      {required this.name,
      required this.phone,
      required this.password,
        this.id,
      this.image,
      this.meal,
      this.mealrate,
      this.deposit,
      this.membertype
      });


  Map<String, dynamic> toMap(){
    return{
      tabMembersColId:id??id,
      tabMembersColName:name,
      tabMembersColPhone:phone,
      tabMembersColPassword:password,
      tabMembersColImage:image,
      tabMembersColMeal:meal,
      tabMembersColMealRate:mealrate,
      tabMembersColDeposit:deposit,
      tabMembersColMemberType:membertype

    };

  }
  factory MemberInfo.fromMap(Map<String,dynamic>map){
    return  MemberInfo(
      id: map[tabMembersColId],
      name: map[tabMembersColName],
      phone: map[tabMembersColPhone],
      password: map[tabMembersColPassword],
      image: map[tabMembersColImage],
      meal: map[tabMembersColMeal],
      mealrate: map[tabMembersColMealRate],
      deposit: map[tabMembersColDeposit],
      membertype: map[tabMembersColMemberType]
    );
  }

  @override
  String toString() {
    return 'MemberInfo{id: $id, name: $name, phone: $phone, password: $password, image: $image, membertype: $membertype, meal: $meal, mealrate: $mealrate, deposit: $deposit}';
  }
}
const String tabMembers='tb_members';
const String tabMembersColId='id';
const String tabMembersColName='name';
const String tabMembersColPhone='phone';
const String tabMembersColPassword='password';
const String tabMembersColImage='image';
const String tabMembersColMeal='meal';
const String tabMembersColMealRate='mealrate';
const String tabMembersColDeposit='deposit';
const String tabMembersColMemberType='membertype';
