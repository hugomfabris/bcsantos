import 'package:bcsantos/inspection_tile.dart';
import 'package:bcsantos/models/hive_models.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InspectionController extends ChangeNotifier {
  final box = Hive.box<Inspection>('inspectionBox');

  InspectionController() {
    init();
  }

  void init() {
    for (var element in box.values) {
      _inspections.add(element);
    }
  }

  final List<Inspection> _inspections = [];
  final List<String> chipsNames = [];

  List<Inspection> get inspections {
    return _inspections;
  }

  void addInspection(Inspection inspection) {
    _inspections.add(inspection);
    notifyListeners();
    box.add(inspection);
  }

  void removeInspection(Inspection inspection) {
    _inspections.remove(inspection);
    notifyListeners();
    inspection.delete();
  }

  // List<String> chipsGenerator() {

  //   for (var element in box.values) {
  //     if (chipsNames.contains(element.name) == false) {
  //       chipsNames.add(element.toString());
  //     }
  //   }
  //   return chipsNames;
  // }

}
