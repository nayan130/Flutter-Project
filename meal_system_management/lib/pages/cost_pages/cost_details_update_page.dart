import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/cost_details_model.dart';
import '../../provider/details_cost_provider.dart';


class CostUpdateDetailsPage extends StatefulWidget {
  static const String routeName = '/cost_update_details';

  const CostUpdateDetailsPage({Key? key}) : super(key: key);

  @override
  State<CostUpdateDetailsPage> createState() => _CostUpdateDetailsPageState();
}

class _CostUpdateDetailsPageState extends State<CostUpdateDetailsPage> {
  //late String _selectedMember;

  final bazarCostController = TextEditingController();
  final otherCostController = TextEditingController();

  String? _dob;
  String time = DateFormat('dd/MM/yyyy').format(DateTime.now());
  late CostDetails costDetails;
  @override
  void didChangeDependencies() {
    costDetails = ModalRoute.of(context)!.settings.arguments as CostDetails;
    bazarCostController.text = costDetails.bazarcost.toString();
    otherCostController.text = costDetails.othercost.toString();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  //final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    bazarCostController.dispose();
    otherCostController.dispose();
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
        title: const Text('Update Cost'),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Add Cost',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.purpleAccent,
                          fontSize: 25),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: _selectedDate,
                              child: const Text('Select Date ')),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(_dob == null ? ' ${costDetails.date}' : _dob!),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorColor: const Color(0xffff3333),
                      keyboardType: TextInputType.number,
                      controller: bazarCostController,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          labelText: 'Bazar cost',
                          hintText: "Enter total amount",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.9),
                              ))),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorColor: const Color(0xffff3333),
                      keyboardType: TextInputType.number,
                      controller: otherCostController,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          labelText: 'If any other cost',
                          hintText: "Enter other cost amount",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.9),
                              ))),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final status = await Provider.of<DetailsCostProvider>(
                                context,
                                listen: false)
                            .updateCostDetails(
                                costDetails.id!,
                                int.parse(bazarCostController.text),
                                int.parse(otherCostController.text));
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

  void _saveInfo() async {
    // if (formKey.currentState!.validate()) {}
    // final CostDetails newMeal;
    // if(otherCostController.text.isEmpty){
    //   newMeal = CostDetails(
    //       bazarcost: int.parse(bazarCostController.text),
    //       othercost: 0,
    //       date: _dob ?? time);
    // }else if(bazarCostController.text.isEmpty){
    //   newMeal = CostDetails(
    //       bazarcost: 0,
    //       othercost: int.parse(otherCostController.text),
    //       date: _dob ?? time);
    // }
    // else{
    //   newMeal = CostDetails(
    //       bazarcost: int.parse(bazarCostController.text),
    //       othercost: int.parse(otherCostController.text),
    //       date: _dob ?? time);
    // }
    //
    // print(newMeal.toString());
    // final status =
    // await Provider.of<DetailsCostProvider>(context, listen: false)
    //     .allCostDetails(newMeal);
    // if (status) {
    //   Navigator.pop(context);
    // }
  }
}
