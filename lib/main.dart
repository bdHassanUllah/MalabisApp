import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/logic/cubit/authentication_cubit.dart';
import 'package:malabis_app/logic/initcubit.dart';
import 'package:malabis_app/routes/custom_routes.dart';
import 'package:malabis_app/routes/routes_name.dart';

final initCubit = InitCubit();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InitCubit>(create: (context) => InitCubit()),
        BlocProvider<AuthenticationCubit>(create: (context) => AuthenticationCubit()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false, //remove debug banner
      title: 'Malabis App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: CustomRoutes.allRoutes,
      initialRoute: splash,
    )
    );
  }
}