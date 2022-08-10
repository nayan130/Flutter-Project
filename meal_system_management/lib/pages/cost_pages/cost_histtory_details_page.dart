import 'package:flutter/material.dart';
import 'package:meal_system_management/pages/cost_pages/cost_details_update_page.dart';
import 'package:meal_system_management/pages/meal_pages/meal_history_details.dart';
import 'package:meal_system_management/provider/details_cost_provider.dart';
import 'package:provider/provider.dart';


class CostHistoryPage extends StatefulWidget {
  static const String routeName = '/cost_history';
  const CostHistoryPage({Key? key}) : super(key: key);

  @override
  State<CostHistoryPage> createState() => _CostHistoryPageState();
}

class _CostHistoryPageState extends State<CostHistoryPage> {
  // final List<Map<String, dynamic>> _items = List.generate(5,
  //     (index) => {"id": index, "name": "Name $index", "meal": "Meal $index"});
  late String memberType;
  @override
  void didChangeDependencies() {
    memberType=ModalRoute.of(context)!.settings.arguments as String;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cost History Page'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pushNamed(context, MealHistoryPage.routeName);
          },
              child: Text('Meal History', style: TextStyle(color: Colors.yellow, fontSize: 18,),))
        ],
      ),
      body: Stack(
        children: [
          Consumer<DetailsCostProvider>(
            builder: (context, provider, _) => ListView.builder(
              itemCount: provider.allCostMembers.length,
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
                           Text('Bazar Cost  :'),
                            Text(provider.allCostMembers[index].bazarcost!.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Other Cost  :'),
                            Text(provider.allCostMembers[index].othercost
                                .toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Date  :'),
                            Text(provider.allCostMembers[index].date!),
                          ],
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text(
                        provider.allCostMembers[index].date!.substring(0, 2),
                      ),
                    ),
                    trailing: memberType=='Manager'?IconButton(
                      icon: const Icon(Icons.mode_edit_rounded),
                      onPressed: () {
                        Navigator.pushNamed(context, CostUpdateDetailsPage.routeName,
                            arguments: provider.allCostMembers[index]).then((value){
                          setState(() {

                          });
                        });
                      },
                    ):const Text(''),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
