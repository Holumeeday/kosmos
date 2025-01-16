import 'package:bloc/bloc.dart';

class SelectionCubit extends Cubit<bool> {
  SelectionCubit() : super(false); 

  void toggleSelection() => emit(!state);
}
