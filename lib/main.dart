// Team Members
//  - Mustafa,
//  - Mohamad Riza,
//  - Faiz Hasanai,
//  - Shavali Karimi,
//  - Ali Yaser:

// ignore_for_file: unused_field

import 'package:audio_image/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      title: 'Flutter  Player',
    );
  }
}
