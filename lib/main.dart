import 'package:cubit_example/business_logic/counter_cubit.dart';
import 'package:cubit_example/business_logic/posts_cubit.dart';
import 'package:cubit_example/presentation/counter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(create: (context) => CounterCubit(0)),
        BlocProvider<PostCubit>(
            create: (context) => PostCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CounterPage(),
      ),
    );
  }
}
