
import 'package:flutter/material.dart';

RoundWidget(IconData icon, String text, bool arrow){
  return Container(
    padding: EdgeInsets.only(left: 20, right: 15),
    margin: EdgeInsets.only(left: 10, top: 20),
    height: 150,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, size: 25,),
        SizedBox(width: 7,),
        Text(text, style: TextStyle(fontSize: 20),),
        SizedBox(width: 5,),
        Icon(Icons.keyboard_arrow_down)
      ],
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black12
    ),
  );
}