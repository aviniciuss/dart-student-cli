import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/student.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class InsertCommand extends Command {
  final StudentRepository studentRepository;
  final ProductRepository productRepository;

  @override
  String get description => 'Insert Student';

  @override
  String get name => 'insert';

  InsertCommand(this.studentRepository)
      : productRepository = ProductRepository() {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
  }

  @override
  void run() async {
    print('await...');
    final filePath = argResults?['file'];
    final students = File(filePath).readAsLinesSync();

    for (final student in students) {
      final csv = student.split(';');

      final data = csv[2].split(',').map((e) async {
        final course = await productRepository.findByName(e.trim());
        course.isStudent = true;
        return course;
      }).toList();

      final courses = await Future.wait(data);
      final model = Student(
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

      await studentRepository.insert(model);
    }

    print('Student saved');
  }
}
