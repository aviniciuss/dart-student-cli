import 'package:args/command_runner.dart';
import 'package:dart_student_cli/src/commands/students/students_command.dart';

void main(List<String> args) async {
  // final parser = ArgParser();
  // parser.addFlag( 'data', abbr: 'd');
  // parser.addOption( 'name', abbr: 'n');
  // parser.addOption( 'template', abbr: 't');

  // final result = parser.parse(args);

  CommandRunner('ADF CLI', 'ADF CLI')
  ..addCommand(StudentsCommand())
  ..run(args);
}
