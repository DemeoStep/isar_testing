import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_testing/data/model/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_testing/presentation/bloc/department_bloc/department_bloc.dart';
import 'package:isar_testing/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:isar_testing/presentation/departments_screen/departments_screen.dart';
import 'package:isar_testing/presentation/home_screen/widget/add_edit_user_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _showUsersDialog({required BuildContext context, User? user}) async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return AddEditUserDialog(
            user: user,
          );
        }) as User?;
    if (result != null) {
      print(result);
      context.read<UsersBloc>().add(UpdateUserEvent(user: result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
      ),
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
                                        state.users[index].department.value
                                                ?.name ??
                                            '',
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
                    BlocBuilder<DepartmentsBloc, DepartmentsState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20)),
                          onPressed: () {
                            (state is GetAllDepartmentsSuccess &&
                                    state.departments.isNotEmpty)
                                ? _showUsersDialog(context: context)
                                : () {};
                          },
                          child: const Text(
                            'Add user',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20)),
                      onPressed: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) =>
                                      GetIt.I<DepartmentsBloc>(),
                                  child: const DepartmentsScreen(),
                                )));
                        context.read<UsersBloc>().add(GetAllUsersEvent());
                        // context
                        //     .read<DepartmentsBloc>()
                        //     .add(GetAllDepartmentsEvent());
                      },
                      child: const Text(
                        'Departments...',
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
