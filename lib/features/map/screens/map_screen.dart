import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rent_house/features/map/screens/location_permision_screen.dart';
import 'package:rent_house/utils/services/location_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.lat, required this.long});

  final double lat;
  final double long;

  @override
  State<MapScreen> createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {
  LatLng latLng = LatLng(41.2965909, 69.2758336);
  final MapController mapController = MapController();
   void initState() {
    super.initState();
    LocationService().checkPermission(
      onRequestCanceled: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LocationPermissionScreen()),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController.move(LatLng(39.6405719, 66.80308), 9);
          print('UPDATED LOCATION');
          setState(() {});
        },
        child: Text('Go to Samarqand'),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(widget.lat, widget.long), // Center the map over London, UK
          initialZoom: 15.2,
        ),
        children: [
          TileLayer(
            // Bring your own tiles
            urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
            // And many more recommended properties!
          ),
          RichAttributionWidget(
            // Include a stylish prebuilt attribution widget that meets all requirments
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => launchUrl(
                  Uri.parse('https://openstreetmap.org/copyright'),
                ), // (external)
              ),
              // Also add images...
            ],
          ),
        ],
      ),
    );
  }
}