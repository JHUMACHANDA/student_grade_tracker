class Subject {
  final String name;
  double _mark;

  Subject({required this.name, required double mark}) : _mark = mark;

  double get mark => _mark;

  set mark(double value) {
    _mark = value;
  }

  /// Grade rule:
  /// A -> mark >= 80
  /// B -> mark >= 65
  /// C -> mark >= 50
  /// F -> below 50
  String get grade {
    if (_mark >= 80) {
      return 'A';
    } else if (_mark >= 65) {
      return 'B';
    } else if (_mark >= 50) {
      return 'C';
    } else {
      return 'F';
    }
  }
}