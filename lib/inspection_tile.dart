import 'package:bcsantos/models/history.dart';
import 'package:flutter/material.dart';
import 'package:bcsantos/shell_execute_service.dart';
import 'package:hive/hive.dart';

class InspectionTile extends StatelessWidget {
  const InspectionTile({super.key, required this.historyInspection});

  final History historyInspection;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Center(
                child: DataTable(columns: [
              DataColumn(label: Text('BC/RB', textAlign: TextAlign.center)),
              DataColumn(label: Text('Inspetor', textAlign: TextAlign.center)),
              DataColumn(label: Text('Anotações', textAlign: TextAlign.center)),
              DataColumn(label: Text('Tipo de Inspeção', textAlign: TextAlign.center)),
              DataColumn(label: Text('Data', textAlign: TextAlign.center))
            ], rows: [
              DataRow(cells: [
                DataCell(Text(historyInspection.name!, textAlign: TextAlign.center)),
                DataCell(Text(historyInspection.inspector!, textAlign: TextAlign.center)),
                DataCell(Text(historyInspection.anotations.toString(), textAlign: TextAlign.center)),
                DataCell(Text(historyInspection.inspectionType!, textAlign: TextAlign.center)),
                DataCell(Text(
                    '${historyInspection.inspectionDate.day.toString()}-${historyInspection.inspectionDate.month.toString()}-${historyInspection.inspectionDate.year.toString()}', textAlign: TextAlign.center))
              ])
            ])),
            leading: CircleAvatar(
              child: Text(historyInspection.inspector![0]),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
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
                                const SnackBar(
                                    content: Text('File not opened')));
                          };
                        }
                      }

                      return openFile(historyInspection.checklist);
                    })
              ],
            )));
  }
}
