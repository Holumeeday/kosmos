import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'buddy_activities_state.dart';

class BuddyActivitiesCubit extends Cubit<BuddyActivitiesState> {
  BuddyActivitiesCubit() : super(BuddyActivitiesInitial());
}
