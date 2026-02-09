import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_house/features/map/screens/map_screen.dart';
import 'package:rent_house/utils/services/location_service.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            CupertinoButton.filled(
              child: Text('User current location'),
              onPressed: () async {
                await LocationService().getPermission();
                await LocationService().getCurrentLocation(
                  onSuccess: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        lat: latitudeListen.value,
                        long: longTitudeListen.value,
                      ),
                    ),
                  ),
                );
              },
            ),
            CupertinoButton.filled(
              child: Text('Choose manually'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}