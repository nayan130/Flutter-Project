import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/member_meal_details_model.dart';
import '../../provider/details_meal_provider.dart';


class MemberMealDetailsPage extends StatefulWidget {
  static const String routeName = '/meal_details';

  const MemberMealDetailsPage({Key? key}) : super(key: key);

  @override
  State<MemberMealDetailsPage> createState() =>
      _MemberMealDetailsPageState();
}

class _MemberMealDetailsPageState extends State<MemberMealDetailsPage> {
  //late String _selectedMember;

  final _userDepositController = TextEditingController();
  String? _dob;
  int _meal = 0;
  late String _personName;

  String time=DateFormat('dd/MM/yyyy').format(DateTime.now());

  //final formKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    _personName=ModalRoute.of(context)!.settings.arguments as String;
    print(_personName);
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
        title: const Text('Meal'),
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
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: _selectedDate,
                                child: const Text('Select Date ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),)),
                            SizedBox(
                              width: 8,
                            ),
                            Text(_dob == null
                                ? ' ${time}'
                                : _dob!),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Add Meal',
                              style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
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
                                        splashColor: Colors.red, // inkwell color
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
                                SizedBox(width: 8.5,),

                                Text(
                                  _meal.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                SizedBox(width: 4,),
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.transparent, // button color
                                      child: InkWell(
                                        splashColor: Colors.red, // inkwell color
                                        child: const SizedBox(
                                          width: 20,
                                          height:20,
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
                    SizedBox(height: 10,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextFormField(
                        cursorColor: const Color(0xffff3333),
                        keyboardType: TextInputType.number,
                        controller: _userDepositController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.wallet_giftcard),
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 25,),
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
                      onTap: _saveInfo,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffff3333),
                        ),
                        child: const Center(
                          child: Text(
                            'Save',
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

  void _saveInfo() async {
    // if (formKey.currentState!.validate()) {}
    final MemberMealDetails newMeal;
    if(_userDepositController.text.isEmpty && _meal!=0) {
      newMeal = MemberMealDetails(
          meal: _meal,
          date: _dob??time,
          name:_personName,
          deposit: 0,
        //deposit:par _userDepositController.text

      );
    }
    else  if(_meal==0 &&_userDepositController.text.isNotEmpty) {
      newMeal = MemberMealDetails(
        meal:0,
        date: _dob??time,
        name:_personName,
        deposit:int.parse( _userDepositController.text),
        //deposit:par _userDepositController.text

      );
    }
    else{
      newMeal = MemberMealDetails(
          meal: _meal,
          date: _dob??time,
          name:_personName,
          deposit: int.parse(_userDepositController.text)
        //deposit:par _userDepositController.text

      );
    }

    print(newMeal.toString());
    final status = await Provider.of<DetailsMealProvider>(context, listen: false).addMealDetails(newMeal);
    if (status) {
      Navigator.pop(context);
    }
  }
}
