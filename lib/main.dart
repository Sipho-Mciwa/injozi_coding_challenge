import 'package:flutter/material.dart';
import 'package:injozi_coding_challenge/view/selectRacer.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      title: 'F1 project',
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Select Year',
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: _yearList(context),
      ),
    ));
  }
}

List<String> generateList() {
  DateTime now = DateTime.now();
  List<String> yearList = [];

  for (var year = 2005; year <= now.year; year++) {
    yearList.add(year.toString());
  }
  return (yearList);
}

Widget _buildRow(String year, BuildContext context) {
  return (ListTile(
    title: Center(child: Text(year,
        style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))),
    onTap: () => (
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultDetails(year)),
        )
    ),
    hoverColor: Colors.lightBlueAccent,
  ));
}

Widget _yearList(BuildContext context) {
  final List<String> years = generateList();
  // final List<int> colorCodes = <int>[600, 500, 100];

  return (ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: years.length,
    itemBuilder: (BuildContext context, int index) {
      return (SizedBox(
        height: 50,
        child: _buildRow(years[index], context),
      ));
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  ));
}

void main() => runApp(const MyApp());
