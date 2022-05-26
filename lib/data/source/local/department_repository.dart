import 'package:isar_testing/data/model/department/department.dart';

abstract class DepartmentRepository {
  Future<void> addDepartment(Department department);
  Future<void> updateDepartment(Department department);

  Future<List<Department>> getAll();

  Future<void> deleteLast();
  Future<void> deleteDepartment(int id);
}
