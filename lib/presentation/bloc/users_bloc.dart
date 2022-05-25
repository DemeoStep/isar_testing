import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_testing/data/model/user.dart';
import 'package:isar_testing/data/source/local/user_repository.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final _userRepository = GetIt.I<UserRepository>();

  UsersBloc() : super(UsersInitial()) {
    on<GetAllEvent>((event, emit) => _getAll(event, emit));
    on<AddUserEvent>((event, emit) => _addUser(event, emit));
    on<DeleteLastEvent>((event, emit) => _deleteLastUser(event, emit));

    add(GetAllEvent());
  }

  _getAll(GetAllEvent event, Emitter<UsersState> emit) async {
    emit(GetAllUsersSuccess(users: await _userRepository.getAll()));
  }

  _addUser(AddUserEvent event, Emitter<UsersState> emit) async {
    await _userRepository.addUser(event.user);
    add(GetAllEvent());
  }

  _deleteLastUser(DeleteLastEvent event, Emitter<UsersState> emit) async {
    await _userRepository.deleteLast();
    add(GetAllEvent());
  }
}
