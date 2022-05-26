import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_testing/data/model/user/user.dart';
import 'package:isar_testing/data/source/local/user_repository.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final _userRepository = GetIt.I<UserRepository>();

  UsersBloc() : super(UsersInitial()) {
    on<GetAllUsersEvent>((event, emit) => _getAll(event, emit));
    on<AddUserEvent>((event, emit) => _addUser(event, emit));
    on<DeleteLastEvent>((event, emit) => _deleteLastUser(event, emit));
    on<DeleteUserEvent>((event, emit) => _deleteUser(event, emit));
    on<EditUserEvent>((event, emit) => _editUser(event, emit));
  }

  _getAll(GetAllUsersEvent event, Emitter<UsersState> emit) async {
    var users = await _userRepository.getAll();
    if (users.isNotEmpty) {
      emit(GetAllUsersSuccess(users: users));
    } else {
      emit(UsersInitial());
    }
  }

  _addUser(AddUserEvent event, Emitter<UsersState> emit) async {
    print(event.user.department.value?.name);
    await _userRepository.addUser(event.user);
    add(GetAllUsersEvent());
  }

  _deleteLastUser(DeleteLastEvent event, Emitter<UsersState> emit) async {
    await _userRepository.deleteLast();
    add(GetAllUsersEvent());
  }

  _deleteUser(DeleteUserEvent event, Emitter<UsersState> emit) async {
    await _userRepository.deleteUser(event.id);
    add(GetAllUsersEvent());
  }

  _editUser(EditUserEvent event, Emitter<UsersState> emit) async {
    await _userRepository.updateUser(event.user);
    add(GetAllUsersEvent());
  }
}
