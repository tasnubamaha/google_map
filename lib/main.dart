import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SimpleMap(),
    );
  }
}

class SimpleMap extends StatefulWidget {
  const SimpleMap({Key? key}) : super(key: key);

  @override
  _SimpleMapState createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {

  static final LatLng _kMapCenter =
  LatLng(22.3384 , 91.83168);

  static final CameraPosition _kInitialPosition =
  CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);



 late GoogleMapController _controller;

  Future<void>onMapCreated(GoogleMapController controller) async {
    _controller = controller;
  //  String value = await DefaultAssetBundle.of(context)
  //      .loadString('assets/map_style.json');
  //  _controller.setMapStyle(value);
  }

  void onCameraMove(CameraPosition cameraPosition) {
    debugPrint('${cameraPosition}');
  }

  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: MarkerId("marker_1"),
      //    position: _kMapCenter,
    //      infoWindow: InfoWindow(title: 'Marker 1'),
      //    rotation: 90),
  //    Marker(
   //     markerId: MarkerId("marker_2"),
       position: LatLng(22.3384, 91.83168),
      ),
    };
  }

  Set<Circle> _createCircle() {
    return {
      Circle(
        circleId: CircleId('1'),
        consumeTapEvents: true,
        strokeColor: Colors.teal,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeWidth: 2,
        center: _kMapCenter,
        radius: 5000,
      ),
      Circle(
        circleId: CircleId('2'),
        consumeTapEvents: true,
        strokeColor: Colors.teal,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeWidth: 2,
        center: LatLng(22.3384, 91.83168),
        radius: 6000,
      ),
    };
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:  ListView(
            children: [
        const TextField(
          textAlign: TextAlign.center,
        decoration:  InputDecoration(
        hintText: 'Address'
        ),
      ),
      Container(
        height: 750,
      child:  GoogleMap(
        initialCameraPosition: _kInitialPosition,
        onMapCreated: onMapCreated,
        mapType: MapType.satellite,
        myLocationEnabled: true,
        markers: _createMarker(),
        trafficEnabled: true,
        compassEnabled: true,
        mapToolbarEnabled: false,
    buildingsEnabled: true,
    onTap: (latLong) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
    'Tapped location LatLong is (${latLong.latitude},${latLong.longitude})'),
    ));
    },
    rotateGesturesEnabled: true,
    scrollGesturesEnabled: true,
    zoomControlsEnabled: true,
    zoomGesturesEnabled: true,
    tiltGesturesEnabled: true,
    liteModeEnabled: false,
    onCameraMove: onCameraMove,
    )
    )
    ]
     )
    );
}
}


