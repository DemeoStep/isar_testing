import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:isar_testing/core/di.dart';
import 'package:isar_testing/data/model/department/department.dart';
import 'package:isar_testing/presentation/bloc/department_bloc/department_bloc.dart';
import 'package:isar_testing/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:isar_testing/presentation/home_screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'data/model/user/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var isarDir = await getApplicationSupportDirectory();
  await Isar.open(
    schemas: [UserSchema, DepartmentSchema],
    directory: isarDir.path,
  );
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UsersBloc(),
          ),
          BlocProvider(
            create: (context) => DepartmentsBloc(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
