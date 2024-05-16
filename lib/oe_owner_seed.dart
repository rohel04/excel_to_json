import 'dart:io';
import 'package:oe_owner_seed/excel_parse_to_json.dart';
import 'package:path/path.dart' as path;

Future<void> seedOwner() async {
  String currentDirectory = path.dirname(Platform.script.toFilePath());
  // Construct the file path for the file in the same folder
  String excelFilePath = path.join(currentDirectory, 'owner.xlsx');
  var jsonFilePath = path.join(currentDirectory, 'owner.json');
  await excelToJson(excelFilePath, jsonFilePath);
}
