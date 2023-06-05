import 'package:flutter/material.dart';
import 'package:papai_flutter_auto_complete/papai_flutter_auto_complete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Papai AutoComplete Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Example Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String stringOutput = '';
  @override
  Widget build(BuildContext context) {
    final List<String> stringList = drugList.map((drug) => drug.name).toList();

    void handleOnChange(text) => setState(() => stringOutput = text);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You select '),
                Text(
                  stringOutput,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Search your item'),
            const SizedBox(height: 20),
            PapaiAutoComplete(
                stringList: stringList,
                onChange: handleOnChange,
                enabled: true,
                label: 'Drug name'),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

const List<Drug> drugList = [
  Drug(name: 'Paracetamol (ยาพารา)', shape: DrugShape.tablet),
  Drug(name: 'Azithromycin', shape: DrugShape.tablet),
  Drug(name: 'aspirin', shape: DrugShape.capsule),
  Drug(name: 'ciprofloxacin', shape: DrugShape.tablet),
  Drug(name: 'clarithromycin', shape: DrugShape.tablet),
  Drug(name: 'risedronate', shape: DrugShape.tablet),
  Drug(name: 'gabapentin', shape: DrugShape.tablet),
  Drug(name: 'clopidogrel', shape: DrugShape.tablet),
  Drug(name: 'mycophenolate mofetil', shape: DrugShape.tablet),
  Drug(name: 'venlafaxine', shape: DrugShape.tablet),
  Drug(name: 'dextromethorphan', shape: DrugShape.tablet),
];

class Drug {
  const Drug({
    required this.name,
    required this.shape,
  });
  final String name;
  final DrugShape shape;
}

enum DrugShape { capsule, tablet, liquid }
