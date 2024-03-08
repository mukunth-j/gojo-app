import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gojoapp/firebase_options.dart';
import 'package:gojoapp/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late double myh, myw;
  @override
  Widget build(BuildContext context) {
    myh = MediaQuery.of(context).size.height;
    myw = MediaQuery.of(context).size.width;
    return MaterialApp(
      //home: MyApp(),
      home: MyHomePage(mywidth: myw, myheight: myh),
    );
  }
}
