import 'dart:convert';

import 'address.dart';
import 'course.dart';

class Student {
  final int? id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<Course> courses;
  final Address address;

  Student({
    this.id,
    required this.name,
    this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'nameCourses': nameCourses,
      'courses': courses.map((e) => e.toMap()).toList(),
      'address': address.toMap()
    };

    if (age != null) {
      map['age'] = age;
    }

    return map;
  }

  String toJson() => jsonEncode(toMap());

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      nameCourses: List<String>.from(map['nameCourses'] ?? <String>[]),
      courses: map['courses']
      ?.map<Course>((courseMap) => Course.fromMap(courseMap)).toList() ?? <Course>[],
      address: Address.fromMap(map['address'] ?? <String, dynamic>{}),
    );
  }

  factory Student.fromJson(String json) => Student.fromMap(jsonDecode(json));

  @override
  String toString() {
    return 'Student{id: $id, name: $name, age: $age, nameCourses: $nameCourses, courses: $courses, address: $address}';
  }
}
