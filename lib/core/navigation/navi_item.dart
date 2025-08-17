import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/navigation/navi_item.dart';

class NavigationCubit extends Cubit<NaviItem> {
  NavigationCubit() : super(NaviItem.home);

  void setItem(NaviItem item) => emit(item);
}

enum NaviItem {
  home,
  book,
  profile,
}
