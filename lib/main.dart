import 'package:flutter/material.dart';
import 'package:gallery_viewer_api_app/Controller/CattegoryProvider/Category_Provider.dart';
import 'package:gallery_viewer_api_app/Modal/Modal_classes/Category_Modal_class.dart';
import 'package:gallery_viewer_api_app/Views/Screens/HomeScreen.dart';
import 'package:provider/provider.dart';

import 'Views/Screens/SplashScreen.dart';
import 'Views/Screens/ViewScreen.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CategoryProvider(),
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: 'SplashScreen',
            routes: {
              'SplashScreen': (context) => SplashScreen(),
              'HomeScreen': (context) => HomeScreen(),
              'ViewScreen': (context) => ViewScreen(),
            },
          );
        });
  }
}
