import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/models/buddy_model.dart';

part 'buddy_profile_state.dart';

class BuddyProfileCubit extends Cubit<BuddyProfileState> {
  BuddyProfileCubit()
      : super(const BuddyProfileState(fBuddyModel: DummyBuddyModel()));
}
