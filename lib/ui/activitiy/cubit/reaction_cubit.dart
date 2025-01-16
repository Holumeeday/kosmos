import 'package:bloc/bloc.dart';

class ReactionState {
  final bool isSelectingReaction;
  final String selectedReaction;

  ReactionState({
    required this.isSelectingReaction,
    required this.selectedReaction,
  });

  ReactionState copyWith({
    bool? isSelectingReaction,
    String? selectedReaction,
  }) {
    return ReactionState(
      isSelectingReaction: isSelectingReaction ?? this.isSelectingReaction,
      selectedReaction: selectedReaction ?? this.selectedReaction,
    );
  }
}

class ReactionCubit extends Cubit<ReactionState> {
  ReactionCubit()
      : super(ReactionState(
          isSelectingReaction: false,
          selectedReaction: 'assets/like.svg',
        ));

  void toggleReactionSelection() {
    emit(state.copyWith(isSelectingReaction: !state.isSelectingReaction));
  }

  void selectReaction(String reaction) {
    emit(
        state.copyWith(selectedReaction: reaction, isSelectingReaction: false));
  }
}
