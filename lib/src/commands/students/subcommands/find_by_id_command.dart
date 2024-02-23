import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';

class FindByIdCommand extends Command {
  final StudentRepository repository;

  @override
  String get description => 'Find By Id Student';

  @override
  String get name => 'findById';

  FindByIdCommand(this.repository) {
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }

  @override
  void run() async {
    print('await...');
    final id = int.tryParse(argResults?['id'] ?? '');

    if (id == null) {
      print('Id is required!');
      return;
    }

    final student = await repository.findById(id);
    print('Student (${student.id}):');
    print('|Name: ${student.name}');
    print('|Age: ${student.age ?? 'N/D'}');
    print('|Courses: ${student.nameCourses.toList()}');
    print(
        '|Address: ${student.address.street}, ${student.address.number} ${student.address.zipcode} - ${student.address.city.name}');
  }
}
