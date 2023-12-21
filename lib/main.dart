import 'dart:io';


import 'package:flutter/material.dart';
import 'package:salah_refiner/home.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  // Window management
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(800, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      windowButtonVisibility: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salah Refiner',
      locale: const Locale('ar'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 13, 85, 121)),
        useMaterial3: true,
        fontFamily: 'Traditional Arabic',
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MyHomePage(title: 'تزيين عبارات الدعاء والتوقير'),
      ),
    );
  }
}