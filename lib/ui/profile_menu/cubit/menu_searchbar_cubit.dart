import 'package:bloc/bloc.dart';
import 'menu_searchbar_state.dart';

class SearchBarCubit extends Cubit<SearchBarState> {
  SearchBarCubit() : super(const SearchBarState());

  void setFocus(bool focus) {
    emit(state.copyWith(isFocused: focus));
  }

  void updateSearchText(String text) {
    emit(state.copyWith(searchText: text));
  }

  void clearSearchText() {
    emit(state.copyWith(searchText: ''));
  }
}
