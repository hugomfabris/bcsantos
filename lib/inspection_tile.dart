import 'package:bcsantos/inspection_controller.dart';
import 'package:bcsantos/models/hive_models.dart';
import 'package:flutter/material.dart';
import 'package:bcsantos/services/shell_execute_service.dart';
import 'package:hive/hive.dart';

class InspectionTile extends StatelessWidget {
  InspectionTile({
    super.key,
    required this.inspection,
  });

  final Inspection inspection;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Center(
                child: DataTable(columns: [
              DataColumn(label: Text('BC/RB', textAlign: TextAlign.center)),
              DataColumn(label: Text('Inspetor', textAlign: TextAlign.center)),
              DataColumn(label: Text('Anotações', textAlign: TextAlign.center)),
              DataColumn(
                  label: Text('Tipo de Inspeção', textAlign: TextAlign.center)),
              DataColumn(label: Text('Data', textAlign: TextAlign.center))
            ], rows: [
              DataRow(cells: [
                DataCell(Text(inspection.name!, textAlign: TextAlign.center)),
                DataCell(
                    Text(inspection.inspector!, textAlign: TextAlign.center)),
                DataCell(Text(inspection.anotations.toString(),
                    textAlign: TextAlign.center)),
                DataCell(Text(inspection.inspectionType!,
                    textAlign: TextAlign.center)),
                DataCell(Text(
                    '${inspection.inspectionDate.day.toString()}-${inspection.inspectionDate.month.toString()}-${inspection.inspectionDate.year.toString()}',
                    textAlign: TextAlign.center))
              ])
            ])),
            leading: CircleAvatar(
              child: Text(inspection.inspector![0]),
            ),
            trailing: IconButton(
                icon: const Icon((Icons.file_upload)),
                onPressed: () {
                  ShellExecuteService shellExecuteService =
                      ShellExecuteService();
                  void openFile(path) async {
                    final filePath = path;
                    final result = await shellExecuteService.openFile(filePath);
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

                  return openFile(inspection.checklist);
                })));
  }
}
