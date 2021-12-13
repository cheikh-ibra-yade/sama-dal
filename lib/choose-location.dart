import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locate_resto/views/home/home-wrapper.dart';
import 'package:locate_resto/views/security/register.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  double intLat;
  double intLng;
  Map donnUser = {};
  Map finder = {};
  Map positionChoisi = {};
  GoogleMapController _mapController;
  GoogleMapController _controller;
  Marker m = Marker();
  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  void _addMarker(double lat, double lng) {
    //setState(() {
    markers.clear();
    
    final id = MarkerId(lat.toString() + lng.toString());
    m = Marker(
      markerId: id,
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      //infoWindow: InfoWindow(title: '${donnUser['fullName']}', snippet: '$lat,$lng'),
      infoWindow: InfoWindow(title: 'l\'Emplacement', snippet: '$lat,$lng'),

    );

    setState(() {
      // adding a new marker to map
      positionChoisi['lat'] = lat;
      positionChoisi['lng'] = lng;
      
      markers[id] = m;
    });
    //_mapController.showMarkerInfoWindow(m.markerId);
    //});
  }

  @override
  Widget build(BuildContext context) {

    intLat = 14.694095090636354;
    intLng =  -17.45974883713694;

    donnUser = ModalRoute.of(context).settings.arguments;
    finder = ModalRoute.of(context).settings.arguments;
    if (finder['lat']!=null) {
      intLat = finder['lat'];
      intLng = finder['lng'];
      _addMarker(intLat,intLng);
      finder.clear();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Emplacement'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_searching),
              label: Text('Enregistrer'),
              
              onPressed: () => {
              Navigator.pop(context, positionChoisi)
              },
            ),
            SizedBox(height: 12.0),
            // IconButton(
            //   tooltip: 'Increase volume by 10',
            //   // child: Text('Enregistrer'),
            //   onPressed: () {
            //     Navigator.pop(context, {
            //       'lat': 18,
            //       'lng': 1313,
            //     });
            //   }, //_mapController == null

            //   icon: Icon(Icons.home),
            // )
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //       return Home();
        //     }));
        //   },
        //   child: Icon(Icons.navigate_next),
        // ),
        body: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
            target: LatLng(intLat, intLng),
            zoom: 14.4746,
          ),
          myLocationButtonEnabled: true,
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(markers.values),
          onTap: (latLng) {
            _addMarker(latLng.latitude, latLng.longitude);
          },
        ));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
//      _showHome();
      //start listening after map is created
    });
  }
}
