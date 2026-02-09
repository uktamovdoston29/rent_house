import 'package:bloc/bloc.dart';
import 'package:rent_house/features/splash&onboard/cubit/onboard_state.dart';

class OnboardCubit extends Cubit<OnboardState> {
  OnboardCubit() : super(OnboardSuccessState());

  void changeIndex(int index) {
    emit(OnboardSuccessState(currentindex: index));
  }

  void nextPage() {
    final state = this.state;
    if (state is OnboardSuccessState) {
      if (state.currentindex < OnboardSuccessState.source.length - 1) {
        emit(OnboardSuccessState(currentindex: state.currentindex + 1));
      }
    }
  }
}
