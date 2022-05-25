import 'package:isar_testing/data/model/user.dart';

abstract class UserRepository {
  Future<void> addUser(User user);

  Future<List<User>> getAll();

  Future<void> deleteLast();
}
