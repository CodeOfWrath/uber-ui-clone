
import 'package:flutter/material.dart';


Widget LastOrdersWidget(String Title, String Details, bool isLastOrder){
  return ListTile(
    leading: isLastOrder ? Icon(Icons.access_time_filled, size: 35, color: Colors.black,)
        :Stack(children: [
          Icon(Icons.circle, size: 50, color: Colors.black,),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Icon(Icons.location_on_rounded , size: 25, color: Colors.white,))
    ],),
    title: isLastOrder ? Text(Title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
        :Text(Title, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,),
    subtitle: Text(Details, style: TextStyle(fontSize: 20)),
  );
}