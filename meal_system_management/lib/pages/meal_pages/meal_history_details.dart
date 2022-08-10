import 'package:flutter/material.dart';
import 'package:meal_system_management/provider/details_meal_provider.dart';
import 'package:provider/provider.dart';
import '../cost_pages/cost_histtory_details_page.dart';
import 'meal_details_update_page.dart';

class MealHistoryPage extends StatefulWidget {
  static const String routeName = '/history';
  const MealHistoryPage({Key? key}) : super(key: key);

  @override
  State<MealHistoryPage> createState() => _MealHistoryPageState();
}

class _MealHistoryPageState extends State<MealHistoryPage> {
  late String membertype;
  @override
  void didChangeDependencies() {

    membertype=ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }
  // final List<Map<String, dynamic>> _items = List.generate(5,
  //     (index) => {"id": index, "name": "Name $index", "meal": "Meal $index"});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Page'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pushNamed(context, CostHistoryPage.routeName,arguments: membertype);
          },
              child: const Text('Cost History', style: TextStyle(color: Colors.yellow, fontSize: 18,),))
        ],
      ),
      body: Stack(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(4),
          //   child: Stack(
          //     children: <Widget>[
          //       Positioned.fill(
          //         child: Container(
          //           decoration: const BoxDecoration(
          //             gradient: LinearGradient(
          //               colors: <Color>[
          //                 Color(0xFF0D47A1),
          //                 Color(0xFF1976D2),
          //                 Color(0xFF42A5F5),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       TextButton(
          //         style: TextButton.styleFrom(
          //           padding: const EdgeInsets.all(16.0),
          //           primary: Colors.white,
          //           textStyle: const TextStyle(fontSize: 20),
          //         ),
          //         onPressed: () {},
          //         child: const Text('Gradient'),
          //       ),
          //     ],
          //   ),
          // ),
          Consumer<DetailsMealProvider>(
            builder: (context, provider, _) => ListView.builder(
              itemCount: provider.mealDetailsMember.length,
              itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                elevation: 10,
                margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text('Name   :'),
                            Text(provider.mealDetailsMember[index].name),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Meal  :'),
                            Text(provider.mealDetailsMember[index].meal
                                .toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Deposit  :'),
                            Text(provider.mealDetailsMember[index].deposit
                                .toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Date   :'),
                            Text(provider.mealDetailsMember[index].date),
                          ],
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text(
                        provider.mealDetailsMember[index].date.substring(0, 2),
                      ),
                    ),
                    trailing: membertype=='Manager'?IconButton(
                      icon: const Icon(Icons.mode_edit_rounded),
                      onPressed: () {
                        Navigator.pushNamed(context, MealUpdatePage.routeName,
                            arguments: provider.mealDetailsMember[index]).then((value){
                              setState(() {

                              });
                        });
                      },
                    ):const Text(''),
                  ),
                ),
              ),
            ),
          ),SizedBox(height: 10,),
        ],
      ),
    );
  }
}
