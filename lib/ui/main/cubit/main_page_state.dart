part of 'main_page_cubit.dart';

class MainPageState extends Equatable {
  const MainPageState({
    required this.dSelectedTabIndex,
    required this.dSelectedActivitySource,
  });

  /// Selected tab index
  final int dSelectedTabIndex;

  /// Selected activity source
  final ActivitySourceEnum dSelectedActivitySource;

  MainPageState copyWith({
    int? dSelectedTabIndex,
    ActivitySourceEnum? dSelectedActivitySource,
  }) {
    return MainPageState(
      dSelectedActivitySource:
          dSelectedActivitySource ?? this.dSelectedActivitySource,
      dSelectedTabIndex: dSelectedTabIndex ?? this.dSelectedTabIndex,
    );
  }

  @override
  List<Object> get props => [
        dSelectedTabIndex,
        dSelectedActivitySource,
      ];
}
