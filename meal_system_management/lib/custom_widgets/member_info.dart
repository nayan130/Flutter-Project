import 'package:flutter/material.dart';
import 'package:meal_system_management/static_design.dart';

class CustomInfo extends StatelessWidget {

  String infoName;
  double infoValue;


  CustomInfo(
      {//required this.icons,
        required this.infoName,
      required this.infoValue}); // const CustomInfo({Key? key, required this.infoName, required this.infoValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(infoName=='Mess Balance          ')Icon(Icons.wallet),
            if(infoName=='Total Deposit            ')Icon(Icons.wallet_giftcard),
            if(infoName=='Mess Meal Cost       ')Icon(Icons.set_meal),
            if(infoName=='Mess Total Meal      ')Icon(Icons.equalizer),
            if(infoName=='Mess Meal Rate       ')Icon(Icons.rate_review),
            if(infoName=='Other Cost per head')Icon(Icons.attach_money),
            if(infoName=='Total Other Cost       ')Icon(Icons.attach_money_outlined),
            const SizedBox(width: 30,),
            Text(infoName,style: textColorFont14,),
            const SizedBox(width: 30,),
            infoName=='Mess Total Meal      '?Text(infoValue.toString(),style: textColorFont14,):Text('${infoValue}Taka',style: textColorFont14,),
          ],
        ),
      ],
    );
  }
}
