import 'package:isar/isar.dart';
import 'package:isar_testing/data/model/user.dart';
import 'package:isar_testing/data/source/local/user_repository.dart';
import 'package:path_provider/path_provider.dart';

class UserRepositoryImpl implements UserRepository {
  late final Isar _isar;
  final List<User> users = [];

  UserRepositoryImpl() {
    _init();
  }

  _init() async {
    final dir = await getApplicationSupportDirectory(); // path_provider package
    _isar = await Isar.open(
      schemas: [UserSchema],
      directory: dir.path,
    );
  }

  @override
  Future<void> deleteLast() async {
    try {
      await _isar
          .writeTxn((isar) async => await _isar.users.delete(users.last.id!));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<User>> getAll() async {
    try {
      users.clear();
      users.addAll(await _isar.users.where().findAll());
    } catch (e) {
      print(e);
    }
    return users;
  }

  @override
  Future<void> addUser(User user) async {
    try {
      await _isar.writeTxn((isar) async => await _isar.users.put(user));
    } catch (e) {
      print(e);
    }
  }
}
