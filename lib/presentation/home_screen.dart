import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_testing/data/model/user.dart';
import 'package:isar_testing/data/source/local/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_testing/presentation/bloc/users_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _userRepository = GetIt.I<UserRepository>();

  @override
  Widget build(BuildContext context) {
    context.read<UsersBloc>().add(GetAllEvent());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: BlocBuilder<UsersBloc, UsersState>(
                    builder: (context, state) {
                      if (state is GetAllUsersSuccess) {
                        return ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.grey),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        state.users[index].id.toString(),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.grey),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        state.users[index].firstName,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.grey),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        state.users[index].lastName,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20)),
                  onPressed: () {
                    context.read<UsersBloc>().add(AddUserEvent(
                            user: User(
                          firstName: Random().nextInt(1000).toString(),
                          lastName: (Random().nextDouble() * 1000).toString(),
                        )));
                  },
                  child: const Text(
                    'Add user',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20)),
                  onPressed: () {
                    context.read<UsersBloc>().add(DeleteLastEvent());
                  },
                  child: const Text(
                    'Delete last user',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
