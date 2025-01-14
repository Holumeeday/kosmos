import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/data/repositories/buddies_remote_api_repository.dart';
import 'package:playkosmos_v3/data_transfer_objects/playkosmos_exception.dart';
// ignore: unused_import
import 'package:playkosmos_v3/enums/connection_type.dart';
import 'package:playkosmos_v3/models/buddy_model.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';
import 'package:playkosmos_v3/models/location_model.dart';
import 'package:playkosmos_v3/utils/location_manager.dart';

part 'buddies_state.dart';

/*
 Buddies Cubit
 Supplies dynamic data for the Buddies Page.
 @author: Chidera Chijama
 */
class BuddiesCubit extends Cubit<BuddiesState> {
  final BuddiesRemoteApiRepository fBuddiesRepository;
  final LocationManager fLocationManager;
  BuddiesCubit(
      {required this.fLocationManager, required this.fBuddiesRepository})
      : super(const BuddiesState());

  void fetchBuddies() async {
    // Fetch buddies from the repository
    emit(state.copyWith(status: BuddiesStatus.loading));
    try {
      final fResponse = await fBuddiesRepository.fetchBuddies();
     
      if (fResponse.status == true) {
        // Parse the response and ensure type safety
        final List<BuddyModel> buddies =
            (fResponse.data["data"] as List<dynamic>).map((buddy) {
          try {
            return BuddyModel.fromJson(buddy as Map<String, dynamic>);
          } catch (e) {
            log("Error parsing buddy: $e, Data: $buddy");
            rethrow;
          }
        }).toList();

        log("##########buddies ${buddies.toString()}");

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

  Future<void> fetchUserLocation() async {
    emit(state.copyWith(status: BuddiesStatus.loading));
    try {
      // Fetch current location
      final  location = await fLocationManager.getCurrentUserLocation();
      log('@@########## ${location!.latitude} ${location.longitude}');
      emit(state.copyWith(
          status: BuddiesStatus.success, userLocation: location));
    } on PlaykosmosException catch (e) {
      addError(e);
      emit(state.copyWith(
          errorMessage: e.message, status: BuddiesStatus.failure));
    }
  }
}
