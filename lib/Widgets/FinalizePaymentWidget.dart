
import 'package:flutter/material.dart';

Widget FinalizePaymentWidget(BuildContext context, String price, String title, String subtitle){
  return Container(
    padding: EdgeInsets.only(left: 25, right: 25, top:  30, bottom: 30),
    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
    height: 180,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orangeAccent, Colors.orangeAccent.shade100],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      borderRadius: BorderRadius.circular(25),
    ),
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Row(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("$title \n£$price", style: TextStyle(fontSize: 33,height: 1 , fontWeight: FontWeight.bold,),textAlign: TextAlign.start,),
        ],
      ),
        InkWell(
          child: Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(subtitle, style: TextStyle(fontSize: 23),),
              Icon(Icons.arrow_forward)
            ],
          ),
          onTap: (){},
        )
      ],)
  );
}