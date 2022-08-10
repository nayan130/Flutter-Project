import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/member_meal_details_model.dart';
import '../../provider/details_meal_provider.dart';

class MealUpdatePage extends StatefulWidget {
  static const String routeName = '/meal_update';
  const MealUpdatePage({Key? key}) : super(key: key);

  @override
  State<MealUpdatePage> createState() => _MealUpdatePageState();
}

class _MealUpdatePageState extends State<MealUpdatePage> {
  final _userDepositController = TextEditingController();
  String? _dob;
  int _meal = 0;
  late MemberMealDetails _mealInfo;

  String time = DateFormat('dd/MM/yyyy').format(DateTime.now());

  //final formKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    _mealInfo = ModalRoute.of(context)!.settings.arguments as MemberMealDetails;
    print(_mealInfo.id);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _userDepositController.dispose();
    //_selectedMember.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Meal Update'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'images/bg_login6.jpg',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Add Meal or Deposit Money',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 25),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Card(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: _selectedDate,
                                child: const Text(
                                  'Select Date ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Text(_dob == null ? ' ${_mealInfo.date}' : _dob!),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Add Meal',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.transparent, // button color
                                      child: InkWell(
                                        splashColor:
                                            Colors.red, // inkwell color
                                        child: const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                            size: 10,
                                          ),
                                        ),
                                        onTap: () {
                                          if (_meal > 0) {
                                            setState(() {
                                              _meal--;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.5,
                                ),
                                Text(
                                  _meal == 0
                                      ? _mealInfo.meal.toString()
                                      : _meal.toString(),
                                  //_meal.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.transparent, // button color
                                      child: InkWell(
                                        splashColor:
                                            Colors.red, // inkwell color
                                        child: const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black,
                                            size: 19,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _meal++;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // const Text(
                    //   'Deposit Money',
                    //   style: textColorFont,
                    // ),
                    // const SizedBox(
                    //   width: 20,
                    // ),
                    SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        cursorColor: const Color(0xffff3333),
                        keyboardType: TextInputType.number,
                        controller: _userDepositController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.wallet_giftcard),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            hintText: "Enter Deposit Amount",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.9),
                                ))),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final status = await Provider.of<DetailsMealProvider>(
                                context,
                                listen: false)
                            .updateMealDetails(_mealInfo.id!, _meal);
                        Navigator.pop(context);
                        // final status = await Provider.of<DetailsMealProvider>(
                        //     context,
                        //     listen: false)
                        //     .updateMealDetails(_mealInfo.id!, _meal);
                        print(status);
                        // if(status){
                        //   Navigator.pop(context);
                        // }

                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffff3333),
                        ),
                        child: const Center(
                          child: Text(
                            'Update',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      setState(() {
        _dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }
}
