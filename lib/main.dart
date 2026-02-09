import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_house/core/theme/app_theme.dart';
import 'package:rent_house/features/auth/cubit/auth_cubit.dart';
import 'package:rent_house/features/home/cubit/cubit/home_cubit.dart';
import 'package:rent_house/features/mainscreen/cubit/main_cubit.dart';
import 'package:rent_house/features/mainscreen/screens/main_screen.dart';
import 'package:rent_house/features/splash&onboard/cubit/onboard_cubit.dart';
import 'package:rent_house/features/splash&onboard/screens/splash_screen.dart';
import 'package:rent_house/firebase_options.dart';
import 'package:rent_house/utils/services/hive_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage((message) async {
    print('Message $message');
  });
  final t = await FirebaseMessaging.instance.getToken();
  print('TOKEN $t');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => MainCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "House rent",
      theme: AppTheme.light,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpalshScreen();
          }
          if (snapshot.hasData && snapshot.data != null) {
            return Mainscreen();
          }
          return SpalshScreen();
        },
      ),
    );
  }
}
