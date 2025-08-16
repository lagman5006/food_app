abstract class NavEvent {}

class ChangeTab extends NavEvent {
  final int index;

  ChangeTab(this.index);
}
