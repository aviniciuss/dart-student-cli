import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';

class DeleteCommand extends Command {
  final StudentRepository repository;

  @override
  String get description => 'Delete Student';

  @override
  String get name => 'delete';

  DeleteCommand(this.repository) {
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

    try {
      final student = await repository.findById(id);

      print('Confirms the exclusion of (${student.name.toUpperCase()})? (y|N)');
      final confirm = stdin.readLineSync();

      if (confirm?.toLowerCase() == 'y') {
        await repository.deleteById(id);
        print('Student deleted');
      } else {
        print('Canceled operation');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
