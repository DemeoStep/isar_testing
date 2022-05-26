import 'package:isar/isar.dart';
import 'package:isar_testing/data/model/department/department.dart';

import '../department_repository.dart';

class DepartmentRepositoryImpl implements DepartmentRepository {
  late final _isar = Isar.getInstance();
  final List<Department> departments = [];

  @override
  Future<void> addDepartment(Department department) async {
    try {
      await _isar
          ?.writeTxn((isar) async => await _isar?.departments.put(department));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteDepartment(int id) async {
    try {
      await _isar
          ?.writeTxn((isar) async => await _isar?.departments.delete(id));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteLast() async {
    try {
      await _isar?.writeTxn((isar) async =>
          await _isar?.departments.delete(departments.last.id!));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<Department>> getAll() async {
    try {
      departments.clear();
      departments.addAll(
          await _isar?.departments.where().findAll() as List<Department>);
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
