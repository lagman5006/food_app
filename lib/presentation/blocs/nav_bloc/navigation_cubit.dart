import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/core/navigation/navi_item.dart';

class NavigationCubit extends Cubit<NaviItem> {
  NavigationCubit() : super(NaviItem.home);

  void setTab(NaviItem item) => emit(item);
}