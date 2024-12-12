part of 'main_page_cubit.dart';

class MainPageState extends Equatable {
  const MainPageState({required this.dSelectedTabIndex});

  /// Selected tab index
  final int dSelectedTabIndex;

  MainPageState copyWith({
    int? dSelectedTabIndex,
  }) {
    return MainPageState(
      dSelectedTabIndex: dSelectedTabIndex ?? this.dSelectedTabIndex,
    );
  }

  @override
  List<Object> get props => [dSelectedTabIndex];
}
