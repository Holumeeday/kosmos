import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_review_state.dart';

class EditReviewCubit extends Cubit<EditReviewState> {
  EditReviewCubit() : super(EditReviewInitial());
}
