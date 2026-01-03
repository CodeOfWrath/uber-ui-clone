
import 'package:flutter/material.dart';

Widget ServiceWidget(BuildContext context, String image, String Title, bool promo){
  return InkWell(onTap: (){},
  child: Container(
      height: 200,
      width: 100,
      child: Stack(
        children: [
          Column(mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 25, bottom: 5),
                height: 85,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black45
                ),
                child: Image.asset(image, fit: BoxFit.fill,),
              ),
              Flexible(child:
              Text(Title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ))
            ],),
          promo ?  Positioned(
              top: 12,
              left: 15,
              right: 15,
              child: Container(
                alignment: Alignment.center,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.green
                ),
                child: Text("Promo", style: TextStyle(fontSize: 15, color: Colors.white),textAlign: TextAlign.center,),
              )) : Container()
        ],
      )
  ),);
}
