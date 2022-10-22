import 'dart:js';

import 'package:flutter/material.dart';
import 'package:injozi_coding_challenge/webServices/fetchResults.dart';

import '../model/results.dart';

class ResultDetails extends StatelessWidget {
  final String year;
  const ResultDetails(this.year, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Select Racer',
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: _futureBuilder(int.parse(year), context),
    ));
  }

  Widget _futureBuilder(int year, BuildContext context) {
    return (
      FutureBuilder<Results>(
        future: fetchResults(year),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List? results = snapshot.data?.resultsRecord;
            return (Scaffold(
              body: _resultList(context, results!),
            ));
          } else if (snapshot.hasError) {
            return (Text('${snapshot.error}'));
          }
            return (Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          );
        })
      );
  }

  Widget _buildRow(dynamic resultData,  BuildContext context) {
    return (ListTile(
      title: Center(child:
        Text('Racer: ${resultData['fullName']} | Constructor: ${resultData['constructor']} |  Status: ${resultData['status']} | Title count: ${resultData['titleCount']}',
            style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
      ),
      onTap: () => (
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultDetails(year)),
          )
      ),
      hoverColor: Colors.lightBlueAccent,
    ));
  }

  Widget _resultList(BuildContext context, List<dynamic> resultList) {
    final List<dynamic> newList = getResults(resultList);
    final List<dynamic> filteredList = filterResults(newList);

    return (ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: filteredList.length,
      itemBuilder: (BuildContext context, int index) {
        return (SizedBox(
          height: 50,
          child: _buildRow(filteredList[index], context),
        ));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    ));
  }

  List<dynamic> getResults(List<dynamic> resultList) {
    List<dynamic> newList = [];

    for (int i = 0; i < resultList.length; i++) {
      Map <String, dynamic> results = {
        'fullName': '${resultList[i]['Results'][0]['Driver']['givenName']} '
            '${resultList[i]['Results'][0]['Driver']['familyName']}',
        'Constructor': '${resultList[i]['Results'][0]['Constructor']['name']}',
        'Status': '${resultList[i]['Results'][0]['status']}',
        'raceName': '${resultList[i]['raceName']}',
      };
      newList.add(results);
    }
    return (newList);
  }

  List<dynamic> filterResults(List<dynamic> newList) {
    List<dynamic> filteredList = [];
    List<String> nameList = [];


    for (int i = 0; i < newList.length; i++) {
      List<String> titleList = [];
      for (int j = 0; j < newList.length; j++) {
        if (newList[i]['fullName'] == newList[j]['fullName']) {
          titleList.add(newList[j]['raceName']);
        }
      }
      if (!nameList.contains(newList[i]['fullName'])) {
        nameList.add(newList[i]['fullName']);

        filteredList.add({
          'fullName': newList[i]['fullName'],
          'constructor': newList[i]['Constructor'],
          'status': newList[i]['Status'],
          'titles': titleList,
          'titleCount': titleList.length
        });
      }
    }

    return (filteredList);

  }
}