import 'package:flutter_bloc/flutter_bloc.dart';

enum NaviItem { home, book, profile }

class NavigationCubit extends Cubit<NaviItem> {
  NavigationCubit() : super(NaviItem.home);

  void setTab(NaviItem item) => emit(item);
}
