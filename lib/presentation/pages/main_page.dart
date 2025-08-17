import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/navigation/navi_item.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  final Widget child;
  const MainPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NaviItem>(
      builder: (context, state) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: NaviItem.values.indexOf(state),
            onTap: (index) {
              final item = NaviItem.values[index];
              context.read<NavigationCubit>().setItem(item);

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
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: "Book",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
