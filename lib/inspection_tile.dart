import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bcsantos/controllers/inspection_controller.dart';
import 'package:bcsantos/models/hive_models.dart';
import 'package:flutter/material.dart';
import 'package:bcsantos/services/shell_execute_service.dart';
import 'package:hive/hive.dart';
import 'package:bcsantos/pages/home_page.dart';

class InspectionTile extends StatefulWidget {

  final Inspection inspection;
  final InspectionController inspectionController;

  const InspectionTile(
      {super.key,
      required this.inspection,
      required this.inspectionController});

  @override
  State<InspectionTile> createState() => InspectionTileState();
}

class InspectionTileState extends State<InspectionTile> {
  

  void removeInspection() {

    widget.inspectionController.removeInspection(widget.inspection);

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Center(
                child: DataTable(columns: [
              DataColumn(label: Text('BC/RB', textAlign: TextAlign.center)),
              DataColumn(label: Text('INSPETOR', textAlign: TextAlign.center)),
              DataColumn(label: Text('ANOTAÇÕES', textAlign: TextAlign.center)),
              DataColumn(label: Text('INSPEÇÃO', textAlign: TextAlign.center)),
              DataColumn(label: Text('DATA', textAlign: TextAlign.center))
            ], rows: [
              DataRow(cells: [
                DataCell(Text(widget.inspection.name!, textAlign: TextAlign.center)),
                DataCell(
                    Text(widget.inspection.inspector!, textAlign: TextAlign.center)),
                DataCell(Text(widget.inspection.anotations.toString(),
                    textAlign: TextAlign.center)),
                DataCell(Text(widget.inspection.inspectionType!,
                    textAlign: TextAlign.center)),
                DataCell(Text(
                    '${widget.inspection.inspectionDate.day.toString()}-${widget.inspection.inspectionDate.month.toString()}-${widget.inspection.inspectionDate.year.toString()}',
                    textAlign: TextAlign.center))
              ])
            ])),
            leading: CircleAvatar(
              child: Text(widget.inspection.inspector![0]),
            ),
            trailing: Wrap(children: [
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      removeInspection();
                    });
                  }),
              IconButton(
                  icon: const Icon((Icons.file_upload)),
                  onPressed: () {
                    ShellExecuteService shellExecuteService =
                        ShellExecuteService();
                    void openFile(path) async {
                      final filePath = path;
                      final result =
                          await shellExecuteService.openFile(filePath);
                      if (result) {
                        (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('File opened')));
                        };
                      } else {
                        (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('File not opened')));
                        };
                      }
                    }

                    return openFile(widget.inspection.checklist);
                  })
            ])));
  }
}
