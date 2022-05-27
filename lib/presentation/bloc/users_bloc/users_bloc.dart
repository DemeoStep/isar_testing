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
    on<GetAllUsersEvent>((event, emit) => _getAll(emit));
    on<DeleteLastEvent>((event, emit) => _deleteLastUser(emit));
    on<DeleteUserEvent>((event, emit) => _deleteUser(event, emit));
    on<UpdateUserEvent>((event, emit) => _updateUser(event, emit));
    add(GetAllUsersEvent());
  }

  _getAll(Emitter<UsersState> emit) async {
    await _userRepository.getAll();
    if (_userRepository.users.isNotEmpty) {
      emit(GetAllUsersSuccess(users: _userRepository.users));
    } else {
      emit(UsersInitial());
    }
  }

  _deleteLastUser(Emitter<UsersState> emit) async {
    await _userRepository.deleteLast();
    add(GetAllUsersEvent());
  }

  _deleteUser(DeleteUserEvent event, Emitter<UsersState> emit) async {
    await _userRepository.deleteUser(event.id);
    add(GetAllUsersEvent());
  }

  _updateUser(UpdateUserEvent event, Emitter<UsersState> emit) async {
    await _userRepository.updateUser(event.user);
    add(GetAllUsersEvent());
  }
}
