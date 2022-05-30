import 'package:isar/isar.dart';
import 'package:isar_testing/data/model/department/department.dart';
import 'package:isar_testing/data/model/user/user.dart';

abstract class UserRepository {
  List<User> get users;

  Future<IsarError?> updateUser(User user);

  Future<List<User>> getAll();

  Future<List<User>> getByDepartment(Department department);

  Future<void> deleteLast();

  Future<void> deleteUser(int id);
}
