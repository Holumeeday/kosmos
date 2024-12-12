import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(const MainPageState(dSelectedTabIndex: 0));

  ///To set the view
  void setSelectedIndex(int index) {
    if (index != 2) {
      emit(state.copyWith(dSelectedTabIndex: index));
    }
  }
}
