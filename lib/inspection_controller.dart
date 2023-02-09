import 'package:bcsantos/inspection_tile.dart';
import 'package:bcsantos/models/hive_models.dart';
import 'package:flutter/material.dart';
import 'package:bcsantos/inspections.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InspectionController extends ChangeNotifier {
  final box = Hive.box<History>('historyBox');

  InspectionController() {
    init();
  }

  void init() {
    for (var element in box.values) {
      _inspections.add(element);
    }
  }

  final List<History> _inspections = [];

  List<History> get inspections {
    return _inspections;
  }

  void addInspection(History inspection) {
    _inspections.add(inspection);
    notifyListeners();
    box.add(inspection);
  }

  void removeInspection(History inspection) {
    _inspections.remove(inspection);
    notifyListeners();
    inspection.delete();
  }
}
