import 'dart:io';
import 'package:bcsantos/controllers/inspection_controller.dart';
import 'package:bcsantos/models/hive_models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

///This is the screen where you can add a new Inspection to the hive box
class AddInspectionPage extends StatefulWidget {
  
  final InspectionController inspectionController;
  
  const AddInspectionPage({super.key, required this.inspectionController});

  @override
  State<AddInspectionPage> createState() => _AddInspectionPageState();
}

class _AddInspectionPageState extends State<AddInspectionPage> {
  late TextEditingController _inspectorController;
  late TextEditingController _inspectionTypeController;
  late TextEditingController _anotationsController;
  late TextEditingController _nameController;
  late Box box;
  String? checklistPath;
  String? planPath;
  DateTime? inspectionDate;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Inspection>('inspectionBox');
    _inspectorController = TextEditingController();
    _inspectionTypeController = TextEditingController();
    _anotationsController = TextEditingController();
    _nameController = TextEditingController();

  }

  @override
  void dispose() {
    _inspectorController.dispose();
    _inspectionTypeController.dispose();
    _anotationsController.dispose();
    super.dispose();
  }

  void saveInspection() {
    final inspection = Inspection()
      ..inspector = _inspectorController.text.toUpperCase().trim()
      ..inspectionType = _inspectionTypeController.text.toUpperCase().trim()
      ..anotations = int.parse(_anotationsController.text)
      ..inspectionDate = inspectionDate ?? DateTime.now()
      ..checklist = checklistPath
      ..id = const Uuid().v4()
      ..plan = planPath
      ..name = _nameController.text.toUpperCase().trim();
    widget.inspectionController.addInspection(inspection);
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
            saveInspection();
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
                child: SizedBox(
                  height: 50,
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Barcaça/Rebocador",
                  hintText: "Barcaça/Rebocador",
                ),
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
              const SizedBox(
                height: 20,
              ),

              ///button to pick date
              ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                        context: context,
                        helpText: "Selecione a data",
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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      dialogTitle: "Selecione o checklist da inspeção",
                      allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx'],
                    );

                    if (result != null) {
                      final path = result.paths.first;
                      File file = File(result.files.single.path!);
                      setState(() {
                        checklistPath = path;
                      });
                    } else {
                      showModalBottomSheet(
                          context: context,
                          builder: (ctx) => Container(
                                height: 200,
                                child: Card(
                                    child:
                                        Text("Nenhum checklist selecionado")),
                              ));
                    }
                  },
                  child: Text(checklistPath == null
                      ? "Selecione checklist"
                      : checklistPath!)),
            ],
          ),
        ),
      ),
    );
  }
}
