import 'package:neoweekend/core/error/failure.dart';

class GenreFailure extends Failure {
  final String message;

  GenreFailure(this.message) : super(message);

  @override
  String toString() => message;
}