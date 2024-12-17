import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'buddies_state.dart';

class BuddiesCubit extends Cubit<BuddiesState> {
  BuddiesCubit() : super(BuddiesInitial());
}
