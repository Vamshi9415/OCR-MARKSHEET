import 'dart:io';

import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final List<Map<String, dynamic>> tableData;

  const ResultPage({Key? key, required this.tableData}) : super(key: key);

  Future<void> _exportToExcel(BuildContext context,List<Map<String, dynamic>> tableData, Set uniqueCOs) async {
    final excel = xlsio.Workbook();
    final sheet = excel.worksheets.addWithName('Result Sheet');

    // Add column headers
    sheet.getRangeByIndex(1, 1).setText('Serial Number');
    sheet.getRangeByIndex(1, 2).setText('Student ID');
    var columnIndex = 3;
    for (var co in uniqueCOs) {
      sheet.getRangeByIndex(1, columnIndex++).setText('CO$co Marks');
    }
    sheet.getRangeByIndex(1, columnIndex).setText('Total Marks');

    // Add data rows
    var rowIndex = 2;
    for (var student in tableData) {
      sheet.getRangeByIndex(rowIndex, 1).setNumber(student['serialNumber'].toDouble());
      sheet.getRangeByIndex(rowIndex, 2).setText(student['studentID']);
      columnIndex = 3;
      for (var co in uniqueCOs) {
        sheet.getRangeByIndex(rowIndex, columnIndex++).setNumber((student['coMarks'][co] ?? 0.0).toDouble());
        //sheet.getRangeByIndex(rowIndex, columnIndex++).setNumber(student['coMarks'][co] ?? 0);
      }
      //sheet.getRangeByIndex(rowIndex, columnIndex).setNumber(student['totalMarks']);
      sheet.getRangeByIndex(rowIndex, columnIndex).setNumber(student['totalMarks'].toDouble());
      rowIndex++;
    }

    // Save the Excel file
    final directory = await getApplicationDocumentsDirectory(); // Get app's private storage
    final filePath = '${directory.path}/result_table.xlsx';
    final bytes = excel.saveAsStream();
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    print('Excel file saved at (private): $filePath');

    // Get public downloads directory
    final downloadsDirectory = await getExternalStorageDirectory();
    final publicFilePath = '${downloadsDirectory?.path}/result_table.xlsx';

    // Copy the file to public downloads directory
    await file.copy(publicFilePath);

    // Show download completion dialog
    _showDownloadCompleteDialog(context, publicFilePath);
  }

  void _showDownloadCompleteDialog(BuildContext context, String filePath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download Complete'),
        content: Text('Excel file downloaded to: $filePath'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

    // final directory = await getExternalStorageDirectory();
    // final filePath = '${directory?.path}/result_table.xlsx';
    // final bytes = excel.saveAsStream();
    // final file = File(filePath);
    // await file.writeAsBytes(bytes);
    // print('Excel file saved at: $filePath');

  @override
  Widget build(BuildContext context) {
    Set uniqueCOs = tableData.expand((map) => map['coMarks'].keys).toSet();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Table'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _exportToExcel(context,tableData, uniqueCOs),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            const DataColumn(label: Text('Serial Number')),
            const DataColumn(label: Text('Student ID')),
            ...uniqueCOs.map((co) => DataColumn(label: Text('CO$co Marks'))),
            const DataColumn(label: Text('Total Marks')),
          ],
          rows: tableData.map((student) {
            return DataRow(
              cells: [
                DataCell(Text(student['serialNumber'].toString())),
                DataCell(Text(student['studentID'])),
                ...uniqueCOs.map((co) => DataCell(Text(
                    (student['coMarks'][co] ?? 0).toString()))),
                DataCell(Text(student['totalMarks'].toString())),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}