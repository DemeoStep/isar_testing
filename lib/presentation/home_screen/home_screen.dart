import 'package:flutter/material.dart';
import 'package:isar_testing/data/model/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_testing/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:isar_testing/presentation/home_screen/widget/add_edit_user_dialog.dart';
import 'package:isar_testing/presentation/home_screen/widget/dropdown_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _showUsersDialog({required BuildContext context, User? user}) async {
    var result = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AddEditUserDialog(
            user: user,
          );
        }) as User?;
    if (result != null) {
      context.read<HomeBloc>().add(UpdateUserEvent(user: result));
    }
  }

  _showError({required BuildContext context, required String message}) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                'Error',
                style: TextStyle(color: Colors.red),
              ),
              content: Text(message),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {
                    if (state is HomeErrorState) {
                      _showError(context: context, message: state.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is GetAllSuccess) {
                      var value = 0;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: DropdownWidget(
                              value: value,
                              onChanged: (value) {
                                if (value != null) {
                                  if (value == 0) {
                                    context.read<HomeBloc>().add(GetAllEvent());
                                  } else {
                                    context.read<HomeBloc>().add(
                                        GetAllFilteredEvent(
                                            department:
                                                state.departments[--value]));
                                  }
                                }
                              },
                              list: [
                                'show all',
                                ...state.departments.map((e) => e.name).toList()
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      _showUsersDialog(
                                          context: context,
                                          user: state.users[index]);
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  title: Text(
                                      '${state.users[index].firstName} ${state.users[index].lastName} (${state.users[index].department.value?.name ?? 'no dep'})'),
                                  trailing: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      context.read<HomeBloc>().add(
                                          DeleteUserEvent(
                                              id: state.users[index].id!));
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20)),
                        onPressed: () {
                          (state is GetAllSuccess &&
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
                      await Navigator.of(context).pushNamed('departments');
                      context.read<HomeBloc>().add(GetAllEvent());
                    },
                    child: const Text(
                      'Departments...',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
