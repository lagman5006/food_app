import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
}

class ChangePage extends OnboardingEvent {
  final int pageIndex;

  const ChangePage(this.pageIndex);


  @override
  List<Object?> get props => [pageIndex];

}