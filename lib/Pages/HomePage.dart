import 'package:flutter/material.dart';
import 'package:uber_ui/Widgets/FinalizePaymentWidget.dart';
import 'package:uber_ui/Widgets/LastOrdersWidget.dart';

import '../Widgets/ServiceWidget.dart';
import '../Widgets/UberPlanWidget.dart';
import '../Widgets/UberRideWidgets.dart';
import 'PlanYourRidePage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String dropdownValue = 'Now';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              margin: EdgeInsets.only(left: 15, right: 15, top: 120),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(35)
              ),
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PlanYourRidePage(title: 'Uber UI Home Page')));
                      },
                      icon: Icon(Icons.search_rounded, size: 35,)
                  ),
                  SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width/2,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PlanYourRidePage(title: 'Uber UI Home Page')));
                      },
                      child: TextFormField(
                        readOnly: true,
                        initialValue: 'Where to?',
                        style: TextStyle(fontSize: 35,),
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width/4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black, fontSize: 20),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['Now', 'Later']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  Icon(Icons.access_time_filled, size: 18),
                                  SizedBox(width: 5),
                                  Text(value),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children:  [
                LastOrdersWidget(
                    "Bastos",
                    "Quartier résidentiel, Yaoundé, Cameroun",
                    true
                ),
                Divider(indent: 60, height: 35,),
                LastOrdersWidget(
                    "Melen",
                    "Quartier universitaire, Yaoundé, Cameroun",
                    true
                )
              ],
            ),
            SizedBox(height: 30,),
            FinalizePaymentWidget(context, '170.71', "Filalize payment:", "Pay"),
            Divider(height: 11, thickness: 10, color: Colors.black12,),
            Container(
              margin: EdgeInsets.only(top: 25, bottom: 10, left: 15, right: 15),
              padding: EdgeInsets.only(left: 15, right: 15),
              height: 230,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Title(color: Colors.black, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Suggestions", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      TextButton(onPressed: (){}, child: Text("See all", style: TextStyle(fontSize: 20),))
                    ],
                  )),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                        children:  [

                          ServiceWidget(context, 'assets/icone.png', 'Ride', true),
                          SizedBox(width: 10,),
                          ServiceWidget(context, 'assets/icone.png', 'Package', false),
                          SizedBox(width: 10,),
                          ServiceWidget(context, 'assets/icone.png', 'Rentals', true),
                          SizedBox(width: 10,),
                          ServiceWidget(context, 'assets/icone.png', 'Reserve', false),
                        ]
                    )
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 15),
              padding: EdgeInsets.only(left: 15),
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Title(color: Colors.black, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ways to save with Uber", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    ],
                  )),
                  Expanded(
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children:  [
                            UberPlanWidget(context,'assets/icone.png', 'Uber Moto rides','Affordable motorcycle pick-ups'),
                            SizedBox(width: 15,),
                            UberPlanWidget(context,'assets/icone.png', 'Shuttle rides','Low fares, premium service'),

                          ]
                      )
                  )
                ],
              ),
            ),
            SizedBox(height: 30,),
            PromoCarousel(),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.only(top: 10, left: 15),
              padding: EdgeInsets.only(left: 15),
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Title(color: Colors.black, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ways to save with Uber", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    ],
                  )),
                  Expanded(
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children:  [
                            UberPlanWidget(context,'assets/icone.png', 'Uber Moto rides','Affordable motorcycle pick-ups'),
                            SizedBox(width: 15,),
                            UberPlanWidget(context,'assets/icone.png', 'Shuttle rides','Low fares, premium service'),

                          ]
                      )
                  )
                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}
