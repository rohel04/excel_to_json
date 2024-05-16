import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';

Future<void> excelToJson(String excelFilePath, String jsonFilePath) async {
  try {
    // Load the Excel file
    var bytes = File(excelFilePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    // Assume data is in the first sheet (index 0)
    var sheet = excel.tables.keys.first;
    var table = excel.tables[sheet]!;

    // Convert Excel data to JSON
    List<Map<String, dynamic>> jsonData = [];

    // Iterate over rows (skip header row)
    for (var i = 1; i < table.maxRows; i++) {
      var row = table.rows[i];
      Map<String, dynamic> rowData = {};

      // Iterate over columns
      for (var j = 0; j < table.maxCols; j++) {
        var cellValue =
            row[j]?.value.toString() ?? ''; // Get cell value or empty string
        var columnName = table.rows[0][j]?.value.toString() ??
            ''; // Header row for column name
        rowData[columnName] = cellValue;
      }

      jsonData.add(rowData);
    }

    // Convert JSON data to string
    var jsonString = jsonEncode(jsonData);

    // Write JSON string to file
    var jsonFile = File(jsonFilePath);
    await jsonFile.writeAsString(jsonString);
  } catch (e) {
    log(e.toString());
  }
}
