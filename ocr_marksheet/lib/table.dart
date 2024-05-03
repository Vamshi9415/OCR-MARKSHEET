import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import 'package:mysql_client/mysql_client.dart';
import 'resultPage.dart';
class StudentResult {
  final String studentID;
  final List<Map<String, String>> results;

  StudentResult(this.studentID, this.results);
}
class XmlDataPage extends StatefulWidget {
  final String xmlData;
  const XmlDataPage({Key? key, required this.xmlData}) : super(key: key);
  @override
  _XmlDataPageState createState() => _XmlDataPageState();
}

class _XmlDataPageState extends State<XmlDataPage> {
  final TextEditingController _studentIdController = TextEditingController();
  List<Map<String, String>> _tableData = [];
  List<Map<String, dynamic>> _allStudentData = [];
  int _currentStudentIndex = 0;

  List<Map<String, dynamic>> _studentData = [];

  // List of students
  List<Map<String, String>> students = [
    {"21mcme01": 'Bachu'},
    {"21mcme02": 'Vamshi'},
    {"21mcme03": 'Vambhb'},
    {"21mcme04": 'bhb Bachu'},
    {"21mcme05": 'Vamhbhshi Bachu'},
    {"21mcme06": 'Vamsbhhi Bachu'},
  ];

  @override
  void initState() {
    super.initState();
    _parseXMLData();
    _studentIdController.text = students[_currentStudentIndex].keys.first;
  }

  void _parseXMLData() {
    final document = xml.XmlDocument.parse(widget.xmlData);
    final questions = document.findAllElements('question');

    for (var question in questions) {
      final subQuestion = question.findElements('sub_question').first.text;
      final questionNumber = question.getAttribute('number')!;
      final co = question.findElements('Co').first.text;
      final maxMarks = question.findElements('Marks').first.text;

      _tableData.add({
        'questionNumber': questionNumber.toString(),
        'subQuestion': subQuestion.toString(),
        'co': co.toString(),
        'maxMarks': maxMarks.toString(),
        'studentID': '',
        'marksObtained': '',
      });
    }
  }
  void _nextStudent() {
    if (_currentStudentIndex < students.length - 1) {
      // 1. Store current student's data
      final currentStudentData = _tableData.map((row) {
        return {
          'questionNumber': row['questionNumber'],
          'subQuestion': row['subQuestion'],
          'co': row['co'],
          'maxMarks': row['maxMarks'],
          'studentID': _studentIdController.text,
          'marksObtained': row['marksObtained'], // Get the latest entered marks
        };
      }).toList();

      // 2. Convert to required type
      final List<Map<String, String>> convertedData = currentStudentData
          .map((e) => e.map((key, value) => MapEntry(key, value.toString())))
          .toList();

      // 3. Add current student data to _allStudentData
      _allStudentData.add({
        'studentID': _studentIdController.text,
        'data': convertedData,
      });

      // 4. Print for demonstration
      print("Current Student Data (after next):");
      print("Student ID: ${_studentIdController.text}");
      for (var questionData in convertedData) {
        print(questionData);
      }
      print("-------------------");

      setState(() {
        _currentStudentIndex++;
        // Clear previous student's marks and update student ID
        _tableData.forEach((row) => row['marksObtained'] = '');
        _studentIdController.text = students[_currentStudentIndex].keys.first;
      });
    } else {
      // Handle reaching the end of the student list
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reached the last student.')),
      );
    }
  }
  // void _nextStudent() {
  //   if (_currentStudentIndex < students.length - 1) {
  //     // Store the current student's data in the list
  //     final studentMarks = _tableData.map((row) {
  //       return {
  //         'questionNumber': row['questionNumber']!,
  //         'subQuestion': row['subQuestion']!,
  //         'co': row['co']!,
  //         'maxMarks': row['maxMarks']!,
  //         'studentID': _studentIdController.text,
  //         'marksObtained': row['marksObtained!'],
  //       };
  //     }).toList();
  //
  //     _allStudentData.add({
  //       'studentID': _studentIdController.text,
  //       'data': studentMarks,
  //     });
  //     print("Current Student Data (after next):");
  //     print("Student ID: ${_studentIdController.text}");
  //     for (var questionData in studentMarks) {
  //       print(questionData);
  //     }
  //     print("-------------------");
  //
  //     setState(() {
  //       _currentStudentIndex++;
  //       // Clear previous student's marks and update student ID
  //       _tableData.forEach((row) => row['marksObtained'] = '');
  //       _studentIdController.text = students[_currentStudentIndex].keys.first;
  //     });
  //   } else {
  //     // Handle reaching the end of the student list (e.g., show a message)
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Reached the last student.')),
  //     );
  //   }
  // }
  void _submitData() {
    // Save current student data
    final currentStudentData = _tableData.map((row) {
      return {
        'questionNumber': row['questionNumber'],
        'subQuestion': row['subQuestion'],
        'co': row['co'],
        'maxMarks': row['maxMarks'],
        'studentID': _studentIdController.text,
        'marksObtained': row['marksObtained'],
      };
    }).toList();

    final List<Map<String, String>> convertedData = currentStudentData
        .map((e) => e.map((key, value) => MapEntry(key, value.toString())))
        .toList();

    // Add current student data to _allStudentData
    _allStudentData.add({
      'studentID': _studentIdController.text,
      'data': convertedData,
    });


        print("\nAll Student Data (after submit):");
        for (var studentData in _allStudentData) {
          print("Student ID: ${studentData['studentID']}");
          print("Data:");
          for (var questionData in studentData['data']) {
            print(questionData);
          }
          print("-------------------");
        }
    // Process the data and create a list of maps for the table
    List<Map<String, dynamic>> tableData = [];

    for (var studentData in _allStudentData) {
      final studentID = studentData['studentID'];
      Map<String, int> coMarks = {};

      int totalMarks = 0;

      for (var questionData in studentData['data']) {
        final co = questionData['co'];
        final marksObtained = int.tryParse(questionData['marksObtained'] ?? '0') ?? 0;
        totalMarks += marksObtained;

        if (coMarks.containsKey(co)) {
          coMarks[co] = coMarks[co]! + marksObtained;
        } else {
          coMarks[co] = marksObtained;
        }
      }

      tableData.add({
        'serialNumber': tableData.length + 1,
        'studentID': studentID,
        'coMarks': coMarks,
        'totalMarks': totalMarks,
      });
    }
    print("Table Data:");
    for (var studentData in tableData) {
      print("Serial Number: ${studentData['serialNumber']}");
      print("Student ID: ${studentData['studentID']}");
      print("CO Marks: ${studentData['coMarks']}");
      print("Total Marks: ${studentData['totalMarks']}");
      print("-------------------");
    }

    // Navigate to the results page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(tableData: tableData),
      ),
    );
  }



  bool _isInteger(String value) {
    final integerPattern = RegExp(r'^-?\d+$');
    return integerPattern.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XML Data Table'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _studentIdController,
              decoration: const InputDecoration(
                labelText: 'Enter Student ID',
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Q. No.')),
                  DataColumn(label: Text('Sub-question')),
                  DataColumn(label: Text('CO')),
                  DataColumn(label: Text('Max Marks')),
                  DataColumn(label: Text('Marks Obtained')),
                ],
                rows: _tableData.map((row) {
                  return DataRow(
                    cells: [
                      DataCell(Text(row['questionNumber'] ?? '')),
                      DataCell(Text(row['subQuestion'] ?? '')),
                      DataCell(Text(row['co'] ?? '')),
                      DataCell(Text(row['maxMarks'] ?? '')),
                      DataCell(
                        TextField(
                          onChanged: (value) {
                            // Validate and update only if it's an integer
                            if (_isInteger(value)) {
                              setState(() {
                                row['marksObtained'] = value;
                              });
                            }
                          },
                          controller: TextEditingController(text: row['marksObtained']),
                          keyboardType: TextInputType.number, // Show numeric keyboard
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _currentStudentIndex < students.length - 1 ? _nextStudent : null,
                child: const Text('Next'),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


