import 'package:flutter/material.dart';

class RacerDetails extends StatelessWidget {
  final dynamic resultData;
  const RacerDetails(this.resultData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Racer Details',
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: _racerDetails(resultData),
    ));
  }

  Widget _racerDetails(dynamic resultData) {
    return (Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text.rich(
            TextSpan(
                text: 'Racer: ', // default text style
                children: <TextSpan>[
                  TextSpan(text: '${resultData['fullName']}', style: TextStyle(fontSize: 25)),
                ],
                style: TextStyle( fontSize: 50)
            ),
          ),
          Text.rich(
            TextSpan(
                text: 'Team: ', // default text style
                children: <TextSpan>[
                  TextSpan(text: '${resultData['constructor']}', style: TextStyle(fontSize: 25)),
                ],
                style: TextStyle( fontSize: 50)
            ),
          ),
          Text.rich(
            TextSpan(
                text: 'Titles: ', // default text style
                children: <TextSpan>[
                  TextSpan(text: '${resultData['titles']}', style: TextStyle(fontSize: 25)),
                ],
                style: TextStyle( fontSize: 50)
            ),
          )
        ]
      )
    ));
  }
}

