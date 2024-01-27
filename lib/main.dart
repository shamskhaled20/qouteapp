import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/utits/thema.dart';
import 'feature/all_qoutes/data/api_add_qoute.dart';
import 'feature/all_qoutes/view/qoutes_list_view.dart';
import 'feature/all_qoutes/view_model/add_qoute_cubit/add_qoute_cubit.dart';
import 'feature/all_qoutes/view_model/get_all_qoutes_cubit/get_all_qoutes_cubit.dart';
void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        // Provide ThemeCubit
        BlocProvider<ThemeCubit>(
          create: (BuildContext context) => ThemeCubit(),
        ),
        // Provide QoutesCubit
        BlocProvider<QoutesCubit>(
          create: (BuildContext context) => QoutesCubit(),
        ),
        // Provide AddQuoteCubit with ApiServiceAddQuoteList
        BlocProvider<AddQuoteCubit>(
          create: (context) =>
              AddQuoteCubit(apiService: ApiServiceAddQuoteList(dio: Dio())),
        ),
        // Provide ThemeProvider
        ChangeNotifierProvider<ThemeProvider>(
          create: (BuildContext context) => ThemeProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final ThemeProvider themeProvider = context.watch<ThemeProvider>();

        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeProvider.themeData,
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          home: QouteList(),
        );
      },
    );
  }
}
