import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imgprc/config/app_colors.dart';
import 'package:imgprc/screens/home_page.dart';

import 'blocs/filter/filter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print(change);
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark()
        ..copyWith(
          primaryColor: AppColors.primaryColor,
          secondaryHeaderColor: AppColors.secondaryColor,
          primaryColorLight: AppColors.lightColor,
          backgroundColor: AppColors.primaryColor,
          accentColor: Colors.cyan[600],
        ),
      theme: ThemeData(
        fontFamily: 'Airbnb Cereal',
        primaryColor: AppColors.primaryColor,
        secondaryHeaderColor: AppColors.secondaryColor,
        primaryColorLight: AppColors.lightColor,
        backgroundColor: AppColors.primaryColor,

        // primaryColor: Colors.lightBlue[800],
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
          providers: [BlocProvider(create: (_) => FilterBloc())],
          child: HomePage()),
    );
  }
}
