import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:uber_ui/Widgets/LastOrdersWidget.dart';
import '../Widgets/RoundWidget.dart';
import 'ChooseATripPage.dart';

class PlanYourRidePage extends StatefulWidget {
  const PlanYourRidePage({super.key, required this.title});
  final String title;

  @override
  State<PlanYourRidePage> createState() => _PlanYourRidePageState();
}

class _PlanYourRidePageState extends State<PlanYourRidePage> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  List<dynamic> fromSuggestions = [];
  List<dynamic> toSuggestions = [];

  LatLng? fromLatLng;
  LatLng? toLatLng;

  // Quartiers de Yaoundé par défaut
  final defaultDistricts = [
    {
      "display_name": "Bastos, Yaoundé",
      "lat": "3.8850",
      "lon": "11.5160",
      "type": "suburb"
    },
    {
      "display_name": "Mvog-Ada, Yaoundé",
      "lat": "3.8660",
      "lon": "11.5200",
      "type": "neighbourhood"
    },
    {
      "display_name": "Nsam, Yaoundé",
      "lat": "3.8400",
      "lon": "11.5000",
      "type": "suburb"
    },
    {
      "display_name": "Bonas, Yaoundé",
      "lat": "3.8700",
      "lon": "11.5100",
      "type": "quarter"
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialiser avec les grands quartiers
    fromSuggestions = defaultDistricts;
    toSuggestions = defaultDistricts;
  }

  Future<void> searchPlace(String query, bool isFrom) async {
    if (query.isEmpty) {
      // Si pas de saisie, garder les quartiers par défaut
      setState(() {
        if (isFrom) {
          fromSuggestions = defaultDistricts;
        } else {
          toSuggestions = defaultDistricts;
        }
      });
      return;
    }

    final url =
        "https://nominatim.openstreetmap.org/search?"
        "q=$query Yaoundé&format=json&addressdetails=1&limit=10&extratags=1";

    final response = await http.get(Uri.parse(url), headers: {
      "User-Agent": "com.codeofwrath.uber_ui"
    });

    if (response.statusCode == 200) {
      final List results = json.decode(response.body);

      // Filtrer uniquement les quartiers
      final filtered = results.where((r) {
        final type = r["type"];
        return type == "suburb" ||
            type == "neighbourhood" ||
            type == "quarter" ||
            type == "hamlet";
      }).toList();

      setState(() {
        if (isFrom) {
          fromSuggestions = filtered.isNotEmpty ? filtered : defaultDistricts;
        } else {
          toSuggestions = filtered.isNotEmpty ? filtered : defaultDistricts;
        }
      });
    }
  }


  void validateSelection() {
    if (fromLatLng != null && toLatLng != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChooseATripPage(
                from: fromLatLng!,
                to: toLatLng!,
              )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veuillez remplir les deux champs")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, size: 35),
          ),
          title: Text("Planifiez votre déplacement", style: TextStyle(fontSize: 35)),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.square(250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 65,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(width: 10),
                          RoundWidget(Icons.access_time_filled, "prendre maintenant", true),
                          RoundWidget(Icons.arrow_forward, "Allé simple", true),
                          RoundWidget(Icons.person, "Four", true),
                        ])),
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 30),
                    Column(
                      children: [
                        Icon(Icons.circle, size: 10, color: Colors.black54),
                        SizedBox(height: 5),
                        Container(color: Colors.black, height: 50, width: 1),
                        SizedBox(height: 5),
                        Icon(Icons.square, size: 10),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                          ),
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: TextFormField(
                            controller: fromController,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Point de départ"),
                            onChanged: (val) => searchPlace(val, true),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                          ),
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: TextFormField(
                            controller: toController,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Destination"),
                            onChanged: (val) => searchPlace(val, false),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          elevation: 10,
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (fromSuggestions.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: fromSuggestions.length,
                  itemBuilder: (context, index) {
                    final s = fromSuggestions[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          fromController.text = s["display_name"];
                          fromLatLng = LatLng(
                              double.parse(s["lat"]), double.parse(s["lon"]));
                          fromSuggestions.clear();
                        });
                      },
                      child: LastOrdersWidget(
                          s["display_name"],
                          s["display_name"], // tu peux mettre une adresse plus détaillée
                          false),
                    );
                  },
                ),
              if (toSuggestions.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: toSuggestions.length,
                  itemBuilder: (context, index) {
                    final s = toSuggestions[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          toController.text = s["display_name"];
                          toLatLng = LatLng(
                              double.parse(s["lat"]), double.parse(s["lon"]));
                          toSuggestions.clear();
                        });
                      },
                      child: LastOrdersWidget(
                          s["display_name"],
                          s["display_name"],
                          false),
                    );
                  },
                ),
              SizedBox(height: 20),
              if (fromLatLng != null && toLatLng != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: validateSelection,
                      icon: Icon(Icons.check, color: Colors.white),
                      label: Text(
                        "VALIDER",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ));
  }
}