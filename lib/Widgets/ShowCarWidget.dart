
import 'package:flutter/material.dart';


Widget ShowCarWidget(String image,String Title, String Details, String prix){
  return ListTile(
    leading: Stack(children: [
      Image.asset(image, height: 80, width: 80),
    ],),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(Title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,),
        Text("$prix FCFA", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,),

      ],
    ),
    subtitle: Text(Details, style: TextStyle(fontSize: 18)),
  );
}