import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refulgence/screens/bottom_navigation/controller/navigation_bloc.dart';
import 'package:refulgence/screens/favourites_screen/view/favourites_screen.dart';
import 'package:refulgence/screens/home_screen/view/home_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: const MainScreenView(),
    );
  }
}

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: _getBodyWidget((state as NavigationSelected).selectedTab),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: (state).selectedTab.index,
            onTap: (index) {
              context
                  .read<NavigationBloc>()
                  .add(TabSelectedEvent(NavigationTab.values[index]));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favourite',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getBodyWidget(NavigationTab tab) {
    switch (tab) {
      case NavigationTab.home:
        return const HomeScreen();
      case NavigationTab.favourite:
        return const FavouritesScreen();
    }
  }
}
