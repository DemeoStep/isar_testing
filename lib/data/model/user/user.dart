import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:isar_testing/data/model/department/department.dart';

part 'user.g.dart';

part 'user.freezed.dart';

@Collection()
@freezed
class User with _$User {
  User._();

  factory User({
    int? id,
    required String firstName,
    required String lastName,
  }) = _User;

  final department = IsarLink<Department>();

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
