import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:injozi_coding_challenge/model/results.dart';


Future<Results> fetchResults(int year) async {
  String url = 'http://ergast.com/api/f1/$year/results/1.json';
  final response = await http.get(Uri.parse(url));

  dynamic resultsObj;
  List<dynamic> resultRecords;

  if (response.statusCode == 200) {
    resultsObj = jsonDecode(response.body);
    resultRecords = resultsObj['MRData']['RaceTable']['Races'];
    return (Results.fromJson(resultRecords));
  } else {
    throw Exception('Failed to load Data');
  }
}