import 'package:flutter/foundation.dart';
import '../models/subject.dart';

class SubjectProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];

  List<Subject> get subjects => List.unmodifiable(_subjects);

  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  void removeSubject(Subject subject) {
    _subjects.remove(subject);
    notifyListeners();
  }

  // .where() used to filter passing subjects (grade is not F)
  List<Subject> get passingSubjects =>
      _subjects.where((subject) => subject.grade != 'F').toList();

  int get totalSubjects => _subjects.length;

  double get averageMark {
    if (_subjects.isEmpty) return 0.0;
    // .map() used to extract marks before averaging
    final marks = _subjects.map((subject) => subject.mark);
    final total = marks.reduce((a, b) => a + b);
    return total / _subjects.length;
  }

  String get overallGrade {
    if (_subjects.isEmpty) return '-';
    final avg = averageMark;
    if (avg >= 80) return 'A';
    if (avg >= 65) return 'B';
    if (avg >= 50) return 'C';
    return 'F';
  }
}