import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bcsantos/models/hive_models.dart';

class ChipsController extends ChangeNotifier {
  
  ChipsController() {
      init();
      }

  final box = Hive.box<Inspection>('inspectionBox');
  final List<String> _chipsNames = [];

  void init() {

    for (var element in box.values) {
      if (_chipsNames.contains(element.name) == false) {
        _chipsNames.add(element.name.toString());
      }
    }
  }

List<String> get chipsNames {
  return _chipsNames;
  }

}

  


  
