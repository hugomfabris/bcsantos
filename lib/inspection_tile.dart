import 'package:bcsantos/model/history.dart';
import 'package:flutter/material.dart';
import 'package:bcsantos/shell_execute_service.dart';


class InspectionTile extends StatelessWidget {
  
  const InspectionTile({super.key, required this.historyInspection});

  final History historyInspection;

  @override
  Widget build(BuildContext context) {

    return Card(
        child: ListTile(
      title: Text(historyInspection.inspector!),
      subtitle: Text(
          '${historyInspection.inspectionDate.day.toString()}-${historyInspection.inspectionDate.month.toString()}-${historyInspection.inspectionDate.year.toString()}'),
      leading: CircleAvatar(
        child: Text(historyInspection.inspector![0]),
      ),
      trailing: IconButton(
        icon: const Icon((Icons.cloud_upload)),
        onPressed: () {
          ShellExecuteService shellExecuteService = ShellExecuteService();
          void openFile(path) async {
            final filePath = path;
            final result = await shellExecuteService.openFile(filePath);
            if (result) {
              (mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('File opened')));
              };
            } else {
              (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('File not opened')));
              };
            }
          }

          return openFile(historyInspection.archive);
        },
      ),
    ));
  }
}
