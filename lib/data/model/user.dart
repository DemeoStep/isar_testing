import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'user.g.dart';

part 'user.freezed.dart';

@Collection()
@freezed
class User with _$User {
  const factory User({
    int? id,
    required String firstName,
    required String lastName,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
