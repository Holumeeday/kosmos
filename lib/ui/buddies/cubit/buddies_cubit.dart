
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/constants/buddies_list.dart';
import 'package:playkosmos_v3/data/repositories/buddies_remote_api_repository.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
// ignore: unused_import
import 'package:playkosmos_v3/enums/connection_type.dart';
import 'package:playkosmos_v3/models/buddy_model.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

part 'buddies_state.dart';

/*
 Buddies Cubit
 Supplies dynamic data for the Buddies Page.
 @author: Chidera Chijama
 */
class BuddiesCubit extends Cubit<BuddiesState> {
  final BuddiesRemoteApiRepository fBuddiesRepository;
  BuddiesCubit({required this.fBuddiesRepository})
      : super(const BuddiesState());

  void fetchBuddies() async {
    // Fetch buddies from the repository
    emit(state.copyWith(status: BuddiesStatus.loading));
    try {
      final fResponse = await fBuddiesRepository.fetchBuddies();
      log("##########fresponse ${fResponse.toString()}");
      if (fResponse.status == true) {
        final buddies = fResponse.data as List<BuddyModel>;
        emit(state.copyWith(
            fBuddiesModel: buddies, status: BuddiesStatus.success));
      } else {
        addError(fResponse.status);
        emit(state.copyWith(
            status: BuddiesStatus.failure,
            errorMessage: fResponse.message,
            data: fResponse));
      }
    } on PlaykosmosException catch (e) {
      addError(e);
      emit(state.copyWith(
          errorMessage: e.message, status: BuddiesStatus.failure));
    }
  }
}
