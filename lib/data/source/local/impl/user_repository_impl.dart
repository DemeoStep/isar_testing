import 'package:isar/isar.dart';
import 'package:isar_testing/data/model/department/department.dart';
import 'package:isar_testing/data/model/user/user.dart';
import 'package:isar_testing/data/source/local/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  late final _isar = Isar.getInstance();
  final List<User> _users = [];

  @override
  List<User> get users => _users;

  @override
  Future<void> deleteUser(int id) async {
    try {
      await _isar?.writeTxn((isar) async => await _isar?.users.delete(id));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteLast() async {
    try {
      await _isar?.writeTxn(
          (isar) async => await _isar?.users.delete(_users.last.id!));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<User>> getAll() async {
    try {
      users.clear();
      var newList = await _isar?.users.where().findAll() as List<User>;
      for (User user in newList) {
        await user.department.load();
      }
      newList.sort((a, b) => a.firstName.compareTo(b.firstName));
      users.addAll(newList);
    } catch (e) {
      print(e);
    }
    return users;
  }

  @override
  Future<IsarError?> updateUser(User user) async {
    try {
      await _isar?.writeTxn((isar) async {
        await _isar?.users.put(user);
        await user.department.save();
      });
      return null;
    } catch (e) {
      return e as IsarError;
    }
  }

  @override
  Future<List<User>> getByDepartment(Department department) async {
    List<User> filteredList = [];
    try {
      await department.users.load();
      for (User user in department.users) {
        await user.department.load();
      }
      filteredList.addAll(department.users);
    } catch (e) {
      print(e);
    }
    return filteredList;
  }
}
