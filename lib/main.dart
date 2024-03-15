import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group4_project/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Patient Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffFFB116)),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          primarySwatch: Colors.blue,
          fontFamily: "OpenSans"),
      initialRoute: GetRoutes.splash,
      getPages: GetRoutes.routes,
    );
  }
}
