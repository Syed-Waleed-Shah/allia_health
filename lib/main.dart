import 'package:allia_health/modules/home/views/home_view.dart';
import 'package:allia_health/themes/dark_theme.dart';
import 'package:allia_health/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Allia Health',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarDividerColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: const HomeView(),
      ),
    );
  }
}
