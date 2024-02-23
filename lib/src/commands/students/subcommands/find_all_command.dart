import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';

class FindAllCommand extends Command {
  final StudentRepository repository;

  @override
  String get description => 'Find All Students';

  @override
  String get name => 'findAll';

  FindAllCommand(this.repository);

  @override
  void run() async {
    print('await...');
    final students = await repository.findAll();
    print('Print courses? (y|N)');

    final showCourses = stdin.readLineSync();
    print('Students:');
    for(final student in students) {
      if(showCourses?.toLowerCase() == 'y') {
          print('${student.id} - ${student.name} ${student.nameCourses.toList()}');
      } else {
        print('${student.id} - ${student.name}');
      }
    }
  }
}
