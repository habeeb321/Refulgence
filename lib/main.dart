import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refulgence/core/app_theme.dart';
import 'package:refulgence/screens/bottom_navigation/view/bottom_navigation.dart';
import 'package:refulgence/screens/detail_screen/bloc/detail_bloc.dart';
import 'package:refulgence/screens/favourites_screen/bloc/favourites_bloc.dart';
import 'package:refulgence/screens/favourites_screen/repository/favourites_repository.dart';
import 'package:refulgence/screens/home_screen/controller/home_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<DetailBloc>(create: (context) => DetailBloc()),
        BlocProvider<FavouritesBloc>(
            create: (context) => FavouritesBloc(FavouritesRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        home: const BottomNavigation(),
      ),
    );
  }
}
