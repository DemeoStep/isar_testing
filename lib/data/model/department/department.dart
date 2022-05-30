import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:isar_testing/data/model/user/user.dart';

part 'department.g.dart';

part 'department.freezed.dart';

@Collection()
@freezed
class Department with _$Department {
  Department._();

  factory Department({
    int? id,
    required String name,
  }) = _Department;

  @Backlink(to: 'department')
  final users = IsarLinks<User>();

  factory Department.fromJson(Map<String, Object?> json) =>
      _$DepartmentFromJson(json);
}
