import 'package:isar_testing/data/model/department/department.dart';

abstract class DepartmentRepository {
  List<Department> get departments;

  Future<void> updateDepartment(Department department);

  Future<List<Department>> getAll();

  Future<void> deleteDepartment(int id);
}
