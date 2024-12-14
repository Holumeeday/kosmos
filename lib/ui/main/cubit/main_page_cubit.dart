import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/enums/activity_source_enum.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit()
      : super(const MainPageState(
          dSelectedTabIndex: 0,
          dSelectedActivitySource: ActivitySourceEnum.arena,
        ));

  ///To set the view
  void setSelectedIndex(int index) {
    if (index != 2) {
      emit(state.copyWith(dSelectedTabIndex: index));
    }
  }

  /// Change selected activity source
  void setSelectedActivitySource(ActivitySourceEnum fSource) {
    emit(state.copyWith(
      dSelectedActivitySource: fSource,
    ));
  }
}
