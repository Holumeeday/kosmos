part of 'buddies_cubit.dart';
enum BuddiesStatus {
  initial,
  loading,
  failure,
  success,
}
/// Buddies State
/// Holds all dynamic data for the Buddies Page.
/// @author: Chidera Chijama

class BuddiesState extends Equatable {
  final List<BuddyModel>? fBuddiesModel;
  final String? errorMessage;
final BuddiesStatus status;
  final GenericResponse? data;
  const BuddiesState(  {this.errorMessage, this.data,
     this.fBuddiesModel, this. status = BuddiesStatus.initial,
  });

  BuddiesState copyWith({List<BuddyModel>? fBuddiesModel, BuddiesStatus? status, String? errorMessage,
    GenericResponse? data, }) {
    return BuddiesState(
      fBuddiesModel: fBuddiesModel ?? this.fBuddiesModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [fBuddiesModel, status, errorMessage,
        data,];
}
