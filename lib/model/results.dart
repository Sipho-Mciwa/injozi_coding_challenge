
class Results {
  List<dynamic> resultsRecord;
  Results({required this.resultsRecord});

  factory Results.fromJson(List<dynamic> list) {
    return (Results(resultsRecord: list));
  }
}