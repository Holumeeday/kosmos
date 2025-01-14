class SearchBarState {
  final bool isFocused;
  final String searchText;

  const SearchBarState({this.isFocused = false, this.searchText = ''});

  SearchBarState copyWith({bool? isFocused, String? searchText}) {
    return SearchBarState(
      isFocused: isFocused ?? this.isFocused,
      searchText: searchText ?? this.searchText,
    );
  }
}

