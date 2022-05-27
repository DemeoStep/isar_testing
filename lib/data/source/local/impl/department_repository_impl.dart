import 'package:isar/isar.dart';
import 'package:isar_testing/data/model/department/department.dart';

import '../department_repository.dart';

class DepartmentRepositoryImpl implements DepartmentRepository {
  late final _isar = Isar.getInstance();
  final List<Department> _departments = [];

  @override
  List<Department> get departments => _departments;

  @override
  Future<void> deleteDepartment(int id) async {
    try {
      await _isar?.writeTxn((isar) async {
        await _isar?.departments.delete(id);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<Department>> getAll() async {
    try {
      departments.clear();
      var newList =
          await _isar?.departments.where().findAll() as List<Department>;
      departments.addAll(newList);
    } catch (e) {
      print(e);
    }
    return departments;
  }

  @override
  Future<void> updateDepartment(Department department) async {
    try {
      await _isar
          ?.writeTxn((isar) async => await _isar?.departments.put(department));
    } catch (e) {
      print(e);
    }
  }
}
