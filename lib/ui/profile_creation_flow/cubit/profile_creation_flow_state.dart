part of 'profile_creation_flow_cubit.dart';

class ProfileCreationFlowState extends Equatable {
  /// The current profile setup stage
  final ProfileCreationFlowEnum fProfileCreationStage;

  /// The second step flow model
  final ProfileCreationFlowModel fFlowModel;

  const ProfileCreationFlowState({
    required this.fProfileCreationStage,
    required this.fFlowModel,
  });

  @override
  List<Object> get props => [
        fProfileCreationStage,
        fFlowModel,
      ];

  ProfileCreationFlowState copyWith({
    ProfileCreationFlowEnum? fProfileCreationStage,
    ProfileCreationFlowModel? fFlowModel,
  }) {
    return ProfileCreationFlowState(
      fFlowModel: fFlowModel ?? this.fFlowModel,
      fProfileCreationStage:
          fProfileCreationStage ?? this.fProfileCreationStage,
    );
  }
}
