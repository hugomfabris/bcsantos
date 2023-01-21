import 'package:bcsantos/inspections.dart';
import 'package:flutter/material.dart';


class InspectionTile extends StatelessWidget {
  const InspectionTile({super.key, required this.inspection});

  final Inspection inspection;

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: ListTile(
      leading: CircleAvatar(child: Text(inspection.inspector![0])),
      title: Text(inspection.inspector!),
      subtitle: Text(inspection.inspectionType!),
      trailing: Text(inspection.inspectionDate!),
    ),
    );
  }
}