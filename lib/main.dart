import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/services.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 13, 85, 121)),
        useMaterial3: true,
        fontFamily: 'Traditional Arabic',
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MyHomePage(title: 'إضافة الصلاة على النبي \ufdfa'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textCont = TextEditingController();
  void _replace() {
    setState(() {
      String text = textCont.text.replaceAll(
          RegExp(
              r'ص[ًٍَُِّّْ]*ل[ًٍَُِّّْ]*ى[ًٍَُِّّْ]* [ًٍَُِّّْ]*ا[ًٍَُِّّْ]*ل[ًٍَُِّّْ]*ل[ًٍَُِّّْ]*ه[ًٍَُِّّْ]* [ًٍَُِّّْ]*ع[ًٍَُِّّْ]*ل[ًٍَُِّّْ]*ي[ًٍَُِّّْ]*ه[ًٍَُِّّْ]* [ًٍَُِّّْ]*و[ًٍَُِّّْ]*س[ًٍَُِّّْ]*ل[ًٍَُِّّْ]*م[ًٍَُِّّْ]*'),
          '\ufdfa');
      textCont.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    const TextStyle generalStyle =
        TextStyle(fontFamily: 'Traditional Arabic', fontSize: 25);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontFamily: 'Traditional Arabic',
            fontSize: 30,
            fontWeight: FontWeight.w500),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
          child: ListView(
            children: <Widget>[
              const Text(
                'أدخل النصّ هنا:',
                style: generalStyle,
              ),
              TextField(
                minLines: 10,
                maxLines: Platform.isAndroid || Platform.isIOS ? 30 : 15,
                textDirection: TextDirection.rtl,
                style: generalStyle,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                textAlign: TextAlign.right,
                controller: textCont,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _replace,
            tooltip: 'استبدال',
            child: const Icon(Icons.find_replace),
          ),
          FloatingActionButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: textCont.text));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                '\u2713 نُسِخَ النص إلى الحافظة',
                style: TextStyle(fontSize: 20),
              )));
            },
            tooltip: 'نسخ',
            child: const Icon(Icons.copy_outlined),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
