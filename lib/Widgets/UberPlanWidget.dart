
import 'package:flutter/material.dart';

Widget UberPlanWidget(BuildContext context, String image, String Title, String Details){
  return Container(
    padding: EdgeInsets.only(bottom: 5),
    margin: EdgeInsets.only(top: 25, bottom: 5),
      height: 350,
      width: MediaQuery.of(context).size.width/1.55,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width/1.58,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black45
            ),
            child: Image.asset(image, fit: BoxFit.contain,),
          ),
          ListTile(
            title: Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(Title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_forward_rounded)
              ],
            ),
            subtitle: Text(Details, style: TextStyle(fontSize: 18)),
          ),
        ],),
  );
}