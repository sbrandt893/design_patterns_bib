import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

void createChecklist() {
  // Excel-Datei erstellen
  var excel = Excel.createExcel();

  // Arbeitsblatt erstellen
  var sheet = excel['Checkliste'];

  // Spaltenüberschriften
  sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue('Aufgabe');
  sheet.cell(CellIndex.indexByString('B1')).value = TextCellValue('Erledigt');

  // Checklisten-Einträge hinzufügen
  var aufgaben = ['Einkaufsliste erstellen', 'Wäsche waschen', 'Zimmer aufräumen', 'E-Mails beantworten'];

  // Aufgaben in die Zeilen schreiben
  for (int i = 0; i < aufgaben.length; i++) {
    sheet.cell(CellIndex.indexByString('A${i + 2}')).value = TextCellValue(aufgaben[i]);
    sheet.cell(CellIndex.indexByString('B${i + 2}')).value = TextCellValue('✅'); // Checkbox-Symbol
  }

  // Optional: Zellenstil anpassen
  CellStyle headerStyle = CellStyle(
    bold: true,
    fontFamily: getFontFamily(FontFamily.Arial),
  );

  sheet.cell(CellIndex.indexByString('A1')).cellStyle = headerStyle;
  sheet.cell(CellIndex.indexByString('B1')).cellStyle = headerStyle;

  // Datei speichern
  String outputFile = "app_progress.xlsx";
  List<int>? fileBytes = excel.save();

  if (fileBytes != null) {
    File(join(outputFile))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
    print('Checkliste wurde erstellt: $outputFile');
  }
}

void main() {
  createChecklist();
}
