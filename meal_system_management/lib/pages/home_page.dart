import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_system_management/custom_widgets/rounded_widgets.dart';
import 'package:meal_system_management/pages/member_pages/login_pages.dart';
import 'package:meal_system_management/pages/meal_pages/meal_history_details.dart';
import 'package:meal_system_management/provider/details_cost_provider.dart';
import 'package:meal_system_management/provider/details_meal_provider.dart';
import 'package:provider/provider.dart';
import '../all_preference.dart';
import '../model/member_model.dart';
import '../provider/add_member_provider.dart';
import '../static_design.dart';
import 'cost_pages/cost_details_page.dart';
import 'meal_pages/meal_details_pages.dart';
import 'member_pages/add_members_pages.dart';
import 'member_pages/member_details_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //when get at the first provider class object
  // late DetailsCostProvider provider;
  //
  // @override
  // void didChangeDependencies() {
  //   provider=Provider.of(context);
  //
  //   super.didChangeDependencies();
  // }
  late final MemberInfo? _person;
  late final DetailsMealProvider mProvider;
  late String name;
  int mealRate = 0;

  @override
  void didChangeDependencies() async {
    _person = ModalRoute.of(context)!.settings.arguments as MemberInfo;
    print('${_person!.id!}');
    mProvider = Provider.of(context);
    final st = await mProvider.getMealsAndDepositByName(_person!.name);
    if (st) {
      setState(() {
        print(mProvider.totalPersonDeposit);
      });
    }
    print('my Deposit' + mProvider.totalPersonDeposit.toString());

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mProvider.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
    } else if (_selectedIndex == 1) {
      Navigator.pushNamed(context, MealHistoryPage.routeName,
          arguments: _person!.membertype);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(

          leading: _person!.image == null
              ? CircleAvatar(
                  radius: 25.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset('images/login_place_holder.png')),
                )
              : CircleAvatar(
                  radius: 25,
                  backgroundImage: FileImage(File(_person!.image!)),
                ),
          title: _person?.name != null
              ? Text(_person!.name)
              : const Text('Person Name!'),
          subtitle: _person?.membertype != null
              ? Text(_person!.membertype!)
              : const Text('_personType.membertype!'),
        ),

        // actions: [
        //   PopupMenuButton(
        //       itemBuilder: (context) => [
        //         PopupMenuItem(
        //             onTap: () {
        //               setLoginStatus(false).then((value) =>
        //                   Navigator.pushReplacementNamed(
        //                       context, LoginManagerPage.routeName));
        //             },
        //             child: const Text('Logout'))
        //       ])
        // ],

        actions: [
          _person!.id == null
              ? TextButton(
                  onPressed: _login,
                  child: const Text(
                    'Login',
                    style: textColorWhite,
                  ))
              : TextButton(
                  onPressed: _logout,
                  child: const Text(
                    'Logout',
                    style: textColorWhite,
                  )),
          if (_person!.membertype == 'Manager')
            TextButton(
                onPressed: _cost,
                child: const Text(
                  'Cost',
                  style: textColorWhite,
                ))
        ],
        //bottom: Bottom,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 1.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                backgroundColor: Colors.deepPurpleAccent,
                selectedItemColor: Colors.white,
                onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.history), label: 'History')
                ]),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                // contentPadding:
                //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right:
                              new BorderSide(width: 1.0, color: Colors.green))),
                  child: const Icon(Icons.home, color: Colors.redAccent),
                ),
                title: Text(
                  "Mess Name",
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.bold),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 70),
                  child: Text(
                      '${DateFormat.yMMMMd('en_US').format(DateTime.now())}'),
                ),
              ),
              Consumer<DetailsMealProvider>(
                builder: (context, provider, _) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    //borderRadius: EdgeInsets.only()
                  ),
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Consumer<DetailsCostProvider>(
                          builder: (context, costProvider, _) => ListTile(
                            // contentPadding:
                            //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      right: new BorderSide(
                                          width: 1.0, color: Colors.green))),
                              child:
                                  Icon(Icons.wallet, color: Colors.redAccent),
                            ),
                            title: Text(
                              "Mess Balance",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 70),
                              child: Text(
                                  '${provider.totalDeposit - (costProvider.totalOtherCost + costProvider.totalBazarCost)} Taka'),
                            ),
                          ),
                        ),
                        ListTile(
                          // contentPadding:
                          //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: new BoxDecoration(
                                border: new Border(
                                    right: new BorderSide(
                                        width: 1.0, color: Colors.green))),
                            child: Icon(Icons.wallet_giftcard,
                                color: Colors.redAccent),
                          ),
                          title: Text(
                            "Total Deposit",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 70),
                            child: Text('${provider.totalDeposit} Taka'),
                          ),
                        ),
                        Consumer<DetailsCostProvider>(
                          builder: (context, costProvider, _) => ListTile(
                            // contentPadding:
                            //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          width: 1.0, color: Colors.green))),
                              child:
                                  Icon(Icons.set_meal, color: Colors.redAccent),
                            ),
                            title: const Text(
                              "Mess Bazaar Cost",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 70),
                              child: Text(
                                  '${costProvider.totalOtherCost + costProvider.totalBazarCost} Taka'),
                            ),
                          ),
                        ),
                        ListTile(
                          // contentPadding:
                          //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1.0, color: Colors.green))),
                            child:
                                Icon(Icons.equalizer, color: Colors.redAccent),
                          ),
                          title: const Text(
                            "Mess Total Meal",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 70),
                            child: Text(provider.totalMeals.toString()),
                          ),
                        ),
                        Consumer<DetailsCostProvider>(
                          builder: (context, costProvider, _) => ListTile(
                            // contentPadding:
                            //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          width: 1.0, color: Colors.green))),
                              child: Icon(Icons.rate_review,
                                  color: Colors.redAccent),
                            ),
                            title: Text(
                              "Mess Meal Rate",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 70),
                              child: Text(
                                  '${((costProvider.totalBazarCost + costProvider.totalOtherCost) / provider.totalMeals).toStringAsFixed(2)} Taka'),
                            ),
                          ),
                        ),
                        Consumer<DetailsCostProvider>(
                          builder: (context, costProvider, _) => ListTile(
                            // contentPadding:
                            //     EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      right: new BorderSide(
                                          width: 1.0, color: Colors.green))),
                              child: Icon(Icons.attach_money_outlined,
                                  color: Colors.redAccent),
                            ),
                            title: const Text(
                              "Total Other Cost",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 70),
                              child:
                                  Text(costProvider.totalOtherCost.toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 8,
                margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Text(mProvider.totalPersonMeals.toString()),
                          RoundedInfo(
                              value: mProvider.totalPersonMeals,
                              valueName: 'My Meal'),
                          RoundedInfo(
                              value: mProvider.totalPersonDeposit,
                              valueName: 'My Deposit'),
                          Consumer<DetailsCostProvider>(
                              builder: (context, provider, _) {
                            if (mProvider.totalMeals == 0) {
                              mealRate = 0;
                            } else {
                              mealRate = ((provider.totalBazarCost +
                                      provider.totalOtherCost) ~/
                                  mProvider.totalMeals);
                            }

                            return RoundedInfo(
                                value: (mealRate * mProvider.totalPersonMeals),
                                valueName: 'My Cost');
                          }),
                          RoundedInfo(
                              value: (mProvider.totalPersonDeposit -
                                  (mealRate * mProvider.totalPersonMeals)),
                              valueName: 'My Balance'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<AddMemberProvider>(
                builder: (context, provider, _) => Container(
                  height: 300,
                  child: ListView.builder(
                      itemCount: provider.allMembers.length,
                      itemBuilder: (context, index) {
                        //name=provider.allMembers[index].name;
                        //provider1.getMealsAndDepositByName(provider.allMembers[index].name);
                        return ListTile(
                          leading: provider.allMembers[index].image == null
                              ? CircleAvatar(
                                  radius: 18.0,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.asset(
                                          'images/login_place_holder.png')),
                                )
                              : CircleAvatar(
                                  radius: 18,
                                  backgroundImage: FileImage(
                                      File(provider.allMembers[index].image!)),
                                ),
                          title: Text(provider.allMembers[index].name),
                          subtitle:
                              Text(provider.allMembers[index].phone.toString()),
                          onTap: () {
                            Navigator.pushNamed(
                                context, MemberDetails.routeName,
                                arguments: provider.allMembers[index].id);
                          },
                          trailing: (_person!.membertype == 'Manager')
                              ? Consumer<DetailsMealProvider>(
                                  builder: (context, mealProvider, _) => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _person!.name !=
                                              provider.allMembers[index].name
                                          ? InkWell(
                                              splashColor:
                                                  Colors.red, // inkwell color
                                              child: const SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.purpleAccent,
                                                  size: 25,
                                                ),
                                              ),
                                              onTap: () async {
                                                final status =
                                                    await _showConfermationDialog();
                                                if (status == true) {
                                                  provider.deleteMember(provider
                                                      .allMembers[index].id!);
                                                  mealProvider.deleteMemberMeal(
                                                      provider.allMembers[index]
                                                          .name);
                                                }
                                              },
                                            )
                                          : Text(''),
                                      InkWell(
                                        splashColor:
                                            Colors.red, // inkwell color
                                        child: const SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.purpleAccent,
                                            size: 25,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              MemberMealDetailsPage.routeName,
                                              arguments: provider
                                                  .allMembers[index].name);
                                          setState(() {});
                                        },
                                      )
                                    ],
                                  ),
                                )
                              : Text(''),
                        );
                      }),
                ),
              ), SizedBox(height: 10,),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(3.0),
        child: (_person!.membertype == 'Manager')
            ? FloatingActionButton(
                onPressed: () {
                  String person = 'Member';
                  Navigator.pushNamed(context, AddMemberPage.routeName,
                      arguments: person);
                },
                tooltip: 'Add new Contact',
                child: const Icon(Icons.add),
              )
            : Text(''),
      ),
    );
  }

  void _login() {
    Navigator.pushNamed(context, LoginManagerPage.routeName);
  }

  void _cost() {
    Navigator.pushNamed(context, CostDetailsPage.routeName);
  }

  void _logout() {
    //Navigator.pushNamed(context, LoginManagerPage.routeName);
    setLoginStatus(false).then((value) =>
        Navigator.pushReplacementNamed(context, LoginManagerPage.routeName));
  }

  Future<bool?> _showConfermationDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Delete Member'),
              content: const Text('Are you sure to delete this member'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('NO')),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('YES')),
              ],
            ));
  }
}
