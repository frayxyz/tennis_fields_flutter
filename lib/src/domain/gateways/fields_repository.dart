import '../entities/field.dart';

abstract class FieldRepository{
  Future<List<Field>> getFields();
}