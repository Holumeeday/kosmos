part of 'profile_creation_flow_cubit.dart';

class ProfileCreationFlowState extends Equatable {
  /// The current profile setup stage
  final ProfileCreationFlowEnum fProfileCreationStage;

  const ProfileCreationFlowState({
    required this.fProfileCreationStage,
  });

  @override
  List<Object> get props => [fProfileCreationStage];

  ProfileCreationFlowState copyWith({
    ProfileCreationFlowEnum? fProfileCreationStage,
  }) {
    return ProfileCreationFlowState(
      fProfileCreationStage:
          fProfileCreationStage ?? this.fProfileCreationStage,
    );
  }
}
