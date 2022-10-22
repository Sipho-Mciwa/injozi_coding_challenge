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
      body: _futureBuilder(int.parse(year),),
    ));
  }

  Widget _futureBuilder(int year) {
    return (
      FutureBuilder<Results>(
        future: fetchResults(year),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return (Center(child: Text(snapshot.data?.resultsRecord[0]['season']),));
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
}