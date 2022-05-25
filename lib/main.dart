import 'package:flutter/material.dart';
import 'package:isar_testing/core/di.dart';
import 'package:isar_testing/presentation/bloc/users_bloc.dart';
import 'package:isar_testing/presentation/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: BlocProvider(
        create: (context) => UsersBloc(),
        child: HomeScreen(),
      ),
    );
  }
}
