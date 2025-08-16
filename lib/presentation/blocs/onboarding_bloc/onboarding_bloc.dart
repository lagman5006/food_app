
import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';


class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState(pageIndex: 0)){
    on<ChangePage>(
       (event, emit) {
         emit(OnboardingState(pageIndex: event.pageIndex));
       },
    );
  }


}
