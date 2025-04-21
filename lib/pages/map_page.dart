import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;

  // Dummy data rambu
  final List<Map<String, dynamic>> rambuData = [
    {
      'position': LatLng(-6.200000, 106.816666), // Jakarta
      'title': 'Rambu Larangan Parkir',
    },
    {
      'position': LatLng(-7.250445, 112.768845), // Surabaya
      'title': 'Rambu Hati-hati Tikungan',
    },
  ];

  Set<Marker> getMarkers() {
    return rambuData.map((data) {
      return Marker(
        markerId: MarkerId(data['title']),
        position: data['position'],
        infoWindow: InfoWindow(title: data['title']),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Interaktif'),
        backgroundColor: Colors.redAccent,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(-6.200000, 106.816666),
          zoom: 5,
        ),
        markers: getMarkers(),
        onMapCreated: (controller) => _mapController = controller,
      ),
    );
  }
}
