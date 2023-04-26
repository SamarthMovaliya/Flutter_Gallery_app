import 'package:flutter/material.dart';
import 'package:gallery_viewer_api_app/Controller/Providers/ThemeProvider/ThemeProvider.dart';
import 'package:gallery_viewer_api_app/Modal/Modal_classes/Category_Modal_class.dart';
import 'package:gallery_viewer_api_app/Views/Screens/HomeScreen.dart';
import 'package:provider/provider.dart';

import 'Controller/Providers/CattegoryProvider/Category_Provider.dart';
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CategoryProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
        builder: (context, _) {
          return MaterialApp(
            theme: ThemeData.light(
              useMaterial3: true
            ),
            darkTheme: ThemeData.dark(
              useMaterial3: true,
            ),
            themeMode:
                (Provider.of<ThemeProvider>(context).themeModal.isDark == false)
                    ? ThemeMode.light
                    : ThemeMode.dark,
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
