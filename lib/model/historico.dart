import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class History extends HiveObject{
  
  @HiveField(0)
  late String? id;
  
  @HiveField(1)
  late String? inspector;
  
  @HiveField(2)
  late String? inspectionType;
  
  @HiveField(3)
  late DateTime inspectionDate;
  
  @HiveField(4)
  late int? anotations;
  
  @HiveField(5)
  late String? archive;

}