import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/constants/buddies_list.dart';
// ignore: unused_import
import 'package:playkosmos_v3/enums/connection_type.dart';
import 'package:playkosmos_v3/models/buddies_model.dart';

part 'buddies_state.dart';

/*
 Buddies Cubit
 Supplies dynamic data for the Buddies Page.
 @author: Chidera Chijama
 */
class BuddiesCubit extends Cubit<BuddiesState> {
  BuddiesCubit()
      : super( BuddiesState(
          fBuddiesModel: fullBuddiesList,
        ));
}
