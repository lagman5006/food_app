import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/navigation/navi_item.dart';

class MainPage extends StatelessWidget {
  final Widget child;
  const MainPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NaviItem>(
      builder: (context, state) {
        return Scaffold(
          body: child, // Use the child from ShellRoute
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _mapNavItemToIndex(state),
            onTap: (index) {
              final item = _mapIndexToNavItem(index);
              context.read<NavigationCubit>().setTab(item);

              switch (item) {
                case NaviItem.home:
                  context.go('/home');
                  break;
                case NaviItem.book:
                  context.go('/book');
                  break;
                case NaviItem.profile:
                  context.go('/profile');
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: "Book"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        );
      },
    );
  }

  int _mapNavItemToIndex(NaviItem item) {
    switch (item) {
      case NaviItem.home:
        return 0;
      case NaviItem.book:
        return 1;
      case NaviItem.profile:
        return 2;
    }
  }

  NaviItem _mapIndexToNavItem(int index) {
    switch (index) {
      case 0:
        return NaviItem.home;
      case 1:
        return NaviItem.book;
      case 2:
        return NaviItem.profile;
      default:
        return NaviItem.home;
    }
  }
}