import 'dart:io';
import 'package:bcsantos/model/history.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

///This is the screen where you can add a new History to the hive box
class AddHistoryPage extends StatefulWidget {
  const AddHistoryPage({super.key});

  @override
  State<AddHistoryPage> createState() => _AddHistoryPageState();
}

class _AddHistoryPageState extends State<AddHistoryPage> {
  late TextEditingController _inspectorController;
  late TextEditingController _inspectionTypeController;
  late TextEditingController _anotationsController;
  late Box box;
  String? filePath;
  DateTime? inspectionDate;

  @override
  void initState() {
    super.initState();
    box = Hive.box<History>('historyBox');
    _inspectorController = TextEditingController();
    _inspectionTypeController = TextEditingController();
    _anotationsController = TextEditingController();
  }

  @override
  void dispose() {
    _inspectorController.dispose();
    _inspectionTypeController.dispose();
    _anotationsController.dispose();
    super.dispose();
  }

  void saveHistory() {
    final history = History()
      ..inspector = _inspectorController.text
      ..inspectionType = _inspectionTypeController.text
      ..anotations = int.parse(_anotationsController.text)
      ..inspectionDate = inspectionDate ?? DateTime.now()
      ..archive = filePath
      ..id = Uuid().v4();
    box.add(history);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Inspeção"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            saveHistory();
          },
          child: const Icon(Icons.save)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("", 
                style: TextStyle(fontSize: 28.0))),
              ),
              TextField(
                controller: _inspectorController,
                decoration: const InputDecoration(
                  labelText: "Inspetor",
                  hintText: "Inspetor",
                ),
              ),
              TextField(
                controller: _inspectionTypeController,
                decoration: const InputDecoration(
                  labelText: "Tipo de Inspeção",
                  hintText: "Tipo de Inspeção",
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _anotationsController,
                decoration: const InputDecoration(
                  labelText: "Anotações",
                  hintText: "Anotações",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              ///button to pick date
              ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101));
                    setState(() {
                      inspectionDate = date;
                    });
                  },
                  child: Text(inspectionDate == null
                      ? "Selecionar Data"
                      : inspectionDate.toString())),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                        );

                    if (result != null) {
                      final path = result.paths.first;
                      File file = File(result.files.single.path!);
                      setState(() {
                        filePath = path;
                      });
                    } else {
                      showModalBottomSheet(
                          context: context,
                          builder: (ctx) => Container(
                                height: 200,
                                child: Card(
                                    child: Text("Nenhum arquivo selecionado")),
                              ));
                    }
                  },
                  child:
                      Text(filePath == null ? "Selecione arquivo" : filePath!)),
            ],
          ),
        ),
      ),
    );
  }
}
