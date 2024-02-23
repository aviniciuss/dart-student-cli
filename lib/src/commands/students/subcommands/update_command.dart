import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/student.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class UpdateCommand extends Command {
  final StudentRepository studentRepository;
  final ProductRepository productRepository;

  @override
  String get description => 'Update Student';

  @override
  String get name => 'update';

  UpdateCommand(this.studentRepository)
      : productRepository = ProductRepository() {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
    argParser.addOption('id', help: 'Student ID', abbr: 'i');
  }

  @override
  void run() async {
    print('await...');
    final filePath = argResults?['file'];
    final id = argResults?['id'];

    if (id == null) {
      print('Student ID is required');
      return;
    }

    final students = File(filePath).readAsLinesSync();

    if (students.length > 1) {
      print('Report only one student');
      return;
    } else if (students.isEmpty) {
      print('Inform at least one student');
      return;
    }

    final student = students.first;
    final csv = student.split(';');

    final data = csv[2].split(',').map((e) async {
      final course = await productRepository.findByName(e.trim());
      course.isStudent = true;
      return course;
    }).toList();

    final courses = await Future.wait(data);
    final model = Student(
      id: int.parse(id),
      name: csv[0],
      nameCourses: courses.map((e) => e.name).toList(),
      courses: courses,
      address: Address(
        street: csv[3],
        number: int.parse(csv[4]),
        zipcode: csv[5],
        city: City(
          id: 1,
          name: csv[6],
        ),
        phone: Phone(
          ddd: int.parse(csv[7]),
          phone: csv[8],
        ),
      ),
    );

    await studentRepository.update(model);
    print('Student updated');
  }
}
