import 'package:flutter/material.dart';
import 'widgets/pages/homePage.dart';
import 'widgets/pages/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mf-meix-le-tige',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(title: "mf-meix"),
        '/menu': (context) => const MenuPage(),
        //'/more': (context) => MorePage(),
      },
      //home: HomePage(),
    );
  }
}
