import 'package:untitled/data/models/person.dart';

class Student extends Person {
  final double? math;
  final double? physic;
  final double? chemistry;

  Student({
    required super.id,
    required super.name,
    this.math,
    this.physic,
    this.chemistry,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    math: (json["math"] as num?)?.toDouble(),
    physic: (json["physic"] as num?)?.toDouble(),
    chemistry: (json["chemistry"] as num?)?.toDouble(),
  );
}