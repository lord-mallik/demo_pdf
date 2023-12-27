import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';

class FileSaver extends StatefulWidget {
  const FileSaver({super.key});

  @override
  State<FileSaver> createState() => _FileSaverState();
}

class _FileSaverState extends State<FileSaver> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController linkController = TextEditingController(
      text:
          "https://i.pinimg.com/564x/80/d4/90/80d490f65d5e6132b2a6e3b5883785f3.jpg");
  TextEditingController extController = TextEditingController(text: "jpg");

  @override
  void initState() {
    super.initState();
  }

  List<int>? getExcel() {
    final Excel excel = Excel.createExcel();
    final Sheet sheetObject = excel['Sheet1'];
    sheetObject.insertColumn(0);
    // for (int i = 1; i < 10; i++) {
    //   sheetObject.appendRow([i]);
    // }
    List<int>? sheets = excel.encode();
    return sheets;
  }

  MimeType type = MimeType.jpeg;

  List<String> modes = ['Byte proxy', 'File proxy'];

  int currentMode = 0;

  @override
  Widget build(BuildContext context) {
    final Widget widgetToDisplay;

    if (currentMode == 0) {
      widgetToDisplay = Container();
    } else {
      widgetToDisplay = Container();
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('File Saver'),
          actions: [
            DropdownButton<int>(
              value: currentMode,
              underline: Container(),
              items: modes
                  .asMap()
                  .entries
                  .map((entry) => DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  currentMode = value;
                });
              },
            )
          ],
        ),
        body: widgetToDisplay,
      ),
    );
  }
}
