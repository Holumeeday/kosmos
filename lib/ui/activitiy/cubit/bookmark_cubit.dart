import 'package:bloc/bloc.dart';

class BookmarkCubit extends Cubit<bool> {
  BookmarkCubit() : super(false); // Initial state is unbookmarked (false)

  void toggleBookmark() => emit(!state); // Toggle the bookmark state
}
