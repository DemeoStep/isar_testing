import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_testing/data/model/department/department.dart';
import 'package:isar_testing/data/model/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_testing/presentation/bloc/department_bloc/department_bloc.dart';
import 'package:isar_testing/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:isar_testing/presentation/home_screen/widget/add_edit_user_dialog.dart';

import 'widget/add_edit_department_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _showUsersDialog({required BuildContext context, User? user}) {
    showDialog(
        context: context,
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => GetIt.I<UsersBloc>()),
              BlocProvider(create: (context) => DepartmentsBloc()),
            ],
            child: AddEditUserDialog(
              user: user,
            ),
          );
        });
  }

  _showDepartmentsDialog(
      {required BuildContext context, Department? department}) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocProvider(
            create: (context) => DepartmentsBloc(),
            child: AddEditDepartmentDialog(
              department: department,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
                      print(state);
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
                                  IconButton(
                                    onPressed: () {
                                      _showUsersDialog(
                                          context: context,
                                          user: state.users[index]);
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
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
                                    flex: 2,
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
                                        state.users[index].department.value!
                                            .name,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context.read<UsersBloc>().add(
                                          DeleteUserEvent(
                                              id: state.users[index].id!));
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20)),
                      onPressed: () {
                        _showUsersDialog(context: context);
                      },
                      child: const Text(
                        'Add user',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20)),
                      onPressed: () {
                        _showDepartmentsDialog(context: context);
                      },
                      child: const Text(
                        'Add department',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
