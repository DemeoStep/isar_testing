import 'package:isar/isar.dart';
import 'package:isar_testing/data/model/user/user.dart';
import 'package:isar_testing/data/source/local/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  late final _isar = Isar.getInstance();
  final List<User> users = [];

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
      await _isar
          ?.writeTxn((isar) async => await _isar?.users.delete(users.last.id!));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<User>> getAll() async {
    try {
      users.clear();
      users.addAll(await _isar?.users.where().findAll() as List<User>);
      for (User user in users) {
        await user.department.load();
        print('$user.${user.department.value?.name}');
      }
    } catch (e) {
      print(e);
    }
    return users;
  }

  @override
  Future<void> addUser(User user) async {
    print('repository addUser: ${user.department.value?.name}');
    try {
      await _isar?.writeTxn((isar) async => await _isar?.users.put(user));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      await _isar?.writeTxn((isar) async => await _isar?.users.put(user));
    } catch (e) {
      print(e);
    }
  }
}
