import 'package:bcsantos/models/hive_models.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InspectionController extends ChangeNotifier {
  InspectionController() {
    init();
  }

  final box = Hive.box<Inspection>('inspectionBox');
  late List<Inspection> _inspections = [];
  final List<String> _chipsNames = [];

  void init() {
    for (var element in box.values) {
      _inspections.add(element);
      if (_chipsNames.contains(element.name) == false) {
        _chipsNames.add(element.name.toString());
      }
    }
  }

  List<Inspection> get inspections {
    return _inspections;
  }

  set inspections(List<Inspection> inspections) {
    _inspections = inspections;
    notifyListeners();
  }

  List<String> get chipsNames {
    return _chipsNames;
  }

  void addInspection(Inspection inspection) {
    _inspections.add(inspection);
    notifyListeners();
    box.add(inspection);
  }

  void removeInspection(Inspection inspection) {
    inspection.delete();
    _inspections.remove(inspection);
    notifyListeners();
    
  }

  setFilter(String name) {
    _inspections =
        _inspections.where((element) => element.name == name).toList();
    notifyListeners();
  }

  clearFilters() {
    _inspections = [];
    init();
    notifyListeners();
  }
}
