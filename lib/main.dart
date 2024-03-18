import 'dart:ui';

import 'package:blood_donorapp/project1/add.dart';
import 'package:blood_donorapp/project1/otp_screen.dart';
import 'package:blood_donorapp/project1/update.dart';
import 'package:blood_donorapp/project1/register_screen.dart';
import 'package:blood_donorapp/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:blood_donorapp/project1/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:blood_donorapp/project1/otp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Demo App",
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => AddUser(),
        '/update': (context) => UpdateDonor(),
        '/otp':(context) => OTPScreen(),
      },
    );
  }
}
