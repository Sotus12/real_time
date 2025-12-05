import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

// DRIVER pages
import 'pages/role_selection_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/driver_dashboard.dart';
import 'pages/send_location_page.dart';

// USER pages
import 'pages/user_login_page.dart';
import 'pages/user_register_page.dart';
import 'pages/user_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings =
  const Settings(persistenceEnabled: true);

  runApp(const BusTrackingApp());
}

class BusTrackingApp extends StatelessWidget {
  const BusTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real-Time Bus Tracker',
      debugShowCheckedModeBanner: false,
      initialRoute: '/role',
      routes: {
        // Role selection
        '/role': (context) => const RoleSelectionPage(),

        // DRIVER Routes
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const DriverDashboard(),
        '/sendLocation': (context) => const SendLocationPage(),

        // USER Routes
        '/userLogin': (context) => const UserLoginPage(),
        '/userRegister': (context) => const UserRegisterPage(),
        '/userHome': (context) => const UserHomePage(),
      },
    );
  }
}
