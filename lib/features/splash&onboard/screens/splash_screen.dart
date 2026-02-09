import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rent_house/core/gen/assets.gen.dart';
import 'package:rent_house/features/map/screens/location_permision_screen.dart';
import 'package:rent_house/features/splash&onboard/screens/onboard_screen.dart';
import 'package:rent_house/utils/services/location_service.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardScreen()),
      );
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 158,
          width: 137,
          child: Column(children: [Assets.images.mainLogo.image()]),
        ),
      ),
    );
  }
}
