import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salah_refiner/modifyString.dart';

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
  bool value1 = false;
  bool value2 = false;
  Set setOfsymbols = {};
  Map dictOfsymbols = {
    '\ufdfb': 'جل جلاله',
    '\ufdfa': 'صلى الله عليه وسلم',
  };
  void _replace() {
    String text = textCont.text;
    for (var symbol in setOfsymbols) {
      String mushakkalah = insertStringBetweenLetters(dictOfsymbols[symbol], '[ًٍَُِّّْ]*');
      text = text.replaceAll(RegExp(mushakkalah), symbol);
    }
    // text = text.replaceAll(
    //     RegExp(
    //         "r'ص[ًٍَُِّّْ]*ل[ًٍَُِّّْ]*ى[ًٍَُِّّْ]* [ًٍَُِّّْ]*ا[ًٍَُِّّْ]*ل[ًٍَُِّّْ]*ل[ًٍَُِّّْ]*ه[ًٍَُِّّْ]* [ًٍَُِّّْ]*ع[ًٍَُِّّْ]*ل[ًٍَُِّّْ]*ي[ًٍَُِّّْ]*ه[ًٍَُِّّْ]* [ًٍَُِّّْ]*و[ًٍَُِّّْ]*س[ًٍَُِّّْ]*ل[ًٍَُِّّْ]*م[ًٍَُِّّْ]*'"),
    //     '\ufdfa');
    textCont.text = text;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    const TextStyle generalStyle = TextStyle(
        fontFamily: 'Traditional Arabic',
        fontSize: 25,
        fontWeight: FontWeight.bold);
    const TextStyle chkbSecStyle =
        TextStyle(fontFamily: 'Traditional Arabic', fontSize: 28.5);
    const TextStyle chkbTitleStyle =
        TextStyle(fontFamily: 'Traditional Arabic', fontSize: 22.5);

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
                'اختر العبارات التي تبغي استبدالها:',
                style: generalStyle,
              ),
              Column(
                children: [
                  CheckboxListTile(
                    value: value1,
                    onChanged: (v) {
                      setState(() {
                        value1 = v!;
                        value1
                            ? setOfsymbols.add('\ufdfb')
                            : setOfsymbols.remove('\ufdfb');
                      });
                      print(setOfsymbols);
                    },
                    secondary: const Text('\ufdfb', style: chkbSecStyle),
                    title: const Text('جلّ جلاله', style: chkbTitleStyle),
                  ),
                  CheckboxListTile(
                      value: value2,
                      onChanged: (v) {
                        setState(() {
                          value2 = v!;
                          value2
                              ? setOfsymbols.add('\ufdfa')
                              : setOfsymbols.remove('\ufdfa');
                        });
                        print(setOfsymbols);
                      },
                      secondary: const Text('\ufdfa', style: chkbSecStyle),
                      title: const Text('صلى الله عليه وسلم',
                          style: chkbTitleStyle)),
                ],
              ),
              const Text(
                'أدخل النصّ هنا:',
                style: generalStyle,
              ),
              TextField(
                minLines: 10,
                maxLines: Platform.isAndroid || Platform.isIOS ? 30 : 15,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                    fontFamily: 'Traditional Arabic', fontSize: 25),
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
              Clipboard.setData(ClipboardData(text: textCont.text))
                  .then((value) => {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          '\u2713 نُسِخَ النص إلى الحافظة',
                          style: TextStyle(fontSize: 20),
                        )))
                      });
            },
            tooltip: 'نسخ',
            child: const Icon(Icons.copy_outlined),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
