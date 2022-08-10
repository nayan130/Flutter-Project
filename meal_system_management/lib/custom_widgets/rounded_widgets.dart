import 'package:flutter/material.dart';

class RoundedInfo extends StatelessWidget {
int value;
 String valueName;
 RoundedInfo({Key? key,required this.value, required this.valueName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: [
          Container(
            height:70,
            width: 70,
            decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(35)
              //more than 50% of width makes circle
            ),
            child: Center(child: valueName=='My Meal'?Text(value.toString()):Text('${value} Tk',)),
          ),
          SizedBox(height: 5,),
          Text(valueName),
        ],
      ),
    );
  }
}
