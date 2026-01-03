import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:uber_ui/Widgets/ShowCarWidget.dart';

class ChooseATripPage extends StatefulWidget {
  const ChooseATripPage({super.key, required this.from, required this.to});

  final LatLng from;
  final LatLng to;

  @override
  State<ChooseATripPage> createState() => _ChooseATripPageState();
}

class _ChooseATripPageState extends State<ChooseATripPage> {

  final MapController _mapController = MapController();

  // Exemple de liste de marqueurs
  late final List<Marker> _markers = [
    Marker(
      point: widget.from,
      width: 80,
      height: 80,
      child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
    ),
    Marker(
      point: widget.to,
      width: 80,
      height: 80,
      child: const Icon(Icons.location_pin, color: Colors.blue, size: 40),
    ),
  ];

  List<LatLng> _routePoints = [];
  late LatLng _vehiculPosition = widget.from;
  bool _routload = false;
  var _distance = 0.0;
  var _duration = 0.0;
  var _curentDistance = 0.0;


  int? selectedIndex;
  bool isLoading = true;

  final cars = [
    {"image": "assets/car1.png", "title": "Uber Go", "details": "4 min away", "prix": "1700"},
    {"image": "assets/car2.png", "title": "Uber Go", "details": "4 min away", "prix": "1700"},
    {"image": "assets/car3.png", "title": "Uber Premium", "details": "4 min away", "prix": "2700"},
  ];




  Future<void> _fetchRealRoute() async {
    try {
      // OSRM attend longitude,latitude
      final String url =
          'https://router.project-osrm.org/route/v1/driving/'
          '${widget.from.longitude},${widget.from.latitude};'
          '${widget.to.longitude},${widget.to.latitude}'
          '?overview=full&geometries=geojson';

      final response = await http.get(
        Uri.parse(url),
        headers: {"User-Agent": "CodeOfWrathUber_ui"},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['routes'] != null && jsonResponse['routes'].length > 0) {
          final route = jsonResponse['routes'][0];
          final geometry = route['geometry']['coordinates'] as List;

          _routePoints = geometry
              .map((point) => LatLng(point[1].toDouble(), point[0].toDouble()))
              .toList();

          final distance = route['distance'] / 1000.0; // km
          final duration = route['duration'] / 60.0;   // minutes

          setState(() {
            _vehiculPosition = _routePoints.first;
            _routload = true;
            _distance = distance;
            _duration = duration;
          });
        } else {
          print('No route found');
        }
      } else {
        print('Failed to fetch route: ${response.statusCode}');
        // fallback simple
        _routePoints = [widget.from, widget.to];
      }
    } catch (e) {
      print("Error fetching route: $e");
      _routePoints = [widget.from, widget.to];
    }
  }

  @override
  initState(){
    _fetchRealRoute();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                            initialCenter: widget.from,
                            initialZoom: 15,
                            onMapReady: (){
                              setState(() {
                                isLoading = false;
                              });
                            }
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.codeofwrath.uber_ui',
                          ),
                          MarkerLayer(markers: _markers),
                          PolylineLayer(
                              polylines:[
                                Polyline(
                                    points: _routePoints,
                                    borderStrokeWidth: 2.0,
                                    borderColor: Colors.white,
                                    strokeWidth: 4,
                                    color: Colors.red
                                )
                              ]
                          )
                        ],
                      ),
                      if (isLoading)
                        Container(
                          color: Colors.white.withOpacity(0.7),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                    ],
                  )
                )
            ),

            Positioned(
                top: 80,
                left: 25,
                child: InkWell(
                  onTap: (){  Navigator.pop(context); },
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 2, offset: Offset(0,3))]
                    ),
                    height: 70,
                    width: 70,
                    child: Icon(Icons.arrow_back, size: 40,),
                  ),
                )
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height/1.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
                    boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 2, offset: Offset(0,3))]
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Choisir un déplacement", style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),textAlign: TextAlign.center),
                       ],
                    ),
                    SizedBox(height: 10,),
                    Divider(height: 5, thickness: 2, color: Colors.black12),

                  Column(
                    children: [
                      // Image en grand au-dessus
                      if (selectedIndex != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                cars[selectedIndex!]["image"]!,
                                height: 200,
                                width: 200,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 10,),
                              Text("${cars[selectedIndex!]["title"]!}    ${cars[selectedIndex!]["prix"]!} FCFA", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),

                              Divider(height: 25, thickness: 2, color: Colors.black12),


                            ],
                          ),
                        ),

                      // Liste des voitures
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cars.length,
                        itemBuilder: (context, index) {
                          final car = cars[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedIndex == index ? Colors.black : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ShowCarWidget(
                                car["image"]!,
                                car["title"]!,
                                car["details"]!,
                                car["prix"]!,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )

                  ]
                )
              )
            ),
            if (selectedIndex != null)
              Positioned(
                bottom: 20,
                left: 10,
                right: 10,
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text("COMMANDE",style: TextStyle(fontSize: 20, color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),

                  )
                )
              )
          ],
        )
    );
  }
}
