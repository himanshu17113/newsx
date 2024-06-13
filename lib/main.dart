import 'dart:io';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark, systemStatusBarContrastEnforced: false));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});
  // static final defaultLightColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent, brightness: Brightness.light);

  // static final defaultDarkColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent, brightness: Brightness.dark);
  @override
  Widget build(BuildContext context) => DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                        seedColor: lightDynamic?.primary ?? Colors.deepPurple,
                        dynamicSchemeVariant: DynamicSchemeVariant.content,
                        brightness: Brightness.light)
                      ,
                useMaterial3: true),
            darkTheme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                        seedColor: darkDynamic?.primary ?? Colors.deepPurple,
                        dynamicSchemeVariant: DynamicSchemeVariant.content,
                        brightness: Brightness.dark),
                useMaterial3: true),
            home: const SplashScreen(),
          ));
}
