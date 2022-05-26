import 'package:isar_testing/data/model/user/user.dart';

abstract class UserRepository {
  Future<void> addUser(User user);
  Future<void> updateUser(User user);

  Future<List<User>> getAll();

  Future<void> deleteLast();
  Future<void> deleteUser(int id);
}
