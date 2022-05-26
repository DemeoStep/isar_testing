import 'package:isar_testing/data/model/user/user.dart';

abstract class UserRepository {
  List<User> get users;

  Future<void> updateUser(User user);

  Future<List<User>> getAll();

  Future<void> deleteLast();

  Future<void> deleteUser(int id);
}
