import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

void createAppProgressChecklist() {
  var excel = Excel.createExcel();
  var sheet = excel['Design Patterns'];

  // Headers
  sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue('Task');
  sheet.cell(CellIndex.indexByString('B1')).value = TextCellValue('Done');

  // Style für Headers
  CellStyle headerStyle = CellStyle(
    bold: true,
    fontFamily: getFontFamily(FontFamily.Arial),
  );

  // Style für Pattern-Überschriften
  CellStyle patternStyle = CellStyle(
    bold: true,
    fontFamily: getFontFamily(FontFamily.Arial),
  );

  // Headers stylen
  sheet.cell(CellIndex.indexByString('A1')).cellStyle = headerStyle;
  sheet.cell(CellIndex.indexByString('B1')).cellStyle = headerStyle;

  var patterns = [
    'Decorator Pattern',
    'Chain of Responsibility Pattern',
    'Command Pattern',
    'Interpreter Pattern',
    'Iterator Pattern',
    'Mediator Pattern',
    'Memento Pattern',
    'Observer Pattern',
    'State Pattern',
    'Strategy Pattern',
    'Template Method Pattern',
    'Visitor Pattern',
    'Abstract Factory Pattern',
    'Builder Pattern',
    'Factory Method Pattern',
    'Prototype Pattern',
    'Singleton Pattern',
    'Adapter Pattern',
    'Bridge Pattern',
    'Composite Pattern',
    'Facade Pattern',
    'Flyweight Pattern',
    'Proxy Pattern',
  ];

  var tasks = [
    'Kurzinfo',
    'Klassendiagramm',
    'Dart Beispiel',
    'GUI/Flutter Beispiel',
  ];

  int currentRow = 2;

  // Patterns und Tasks einfügen
  for (var pattern in patterns) {
    // Pattern als Überschrift
    sheet.cell(CellIndex.indexByString('A$currentRow')).value = TextCellValue(pattern);
    sheet.cell(CellIndex.indexByString('A$currentRow')).cellStyle = patternStyle;
    currentRow++;

    // Tasks für das Pattern
    for (var i = 0; i < tasks.length; i++) {
      sheet.cell(CellIndex.indexByString('A$currentRow')).value = TextCellValue(tasks[i]);

      // Nur für den ersten Task des ersten Patterns einen Haken setzen
      if (currentRow == 3) {
        sheet.cell(CellIndex.indexByString('B$currentRow')).value = TextCellValue('✅');
      }

      currentRow++;
    }

    // Leerzeile nach den Tasks
    currentRow++;
  }

  // Spaltenbreiten anpassen
  sheet.setColumnWidth(0, 30); // Task
  sheet.setColumnWidth(1, 15); // Done

  // Excel-Datei speichern
  String outputFile = "app_progress.xlsx";
  List<int>? fileBytes = excel.save();

  if (fileBytes != null) {
    File(join(outputFile))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
    print('App Progress Checkliste wurde erstellt: $outputFile');
  }
}

void main() {
  createAppProgressChecklist();
}
