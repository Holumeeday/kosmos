part of 'profile_creation_flow_cubit.dart';

class ProfileCreationFlowState extends Equatable {
  /// The current profile setup stage
  final ProfileCreationFlowEnum fProfileCreationStage;

  /// The second step flow model
  final ProfileCreationFlowModel fFlowModel;

  /// Selected interest group
  final Map<String, List<String>> fSelectedInterestMap;

  const ProfileCreationFlowState({
    required this.fProfileCreationStage,
    required this.fFlowModel,
    required this.fSelectedInterestMap,
  });

  @override
  List<Object> get props => [
        fProfileCreationStage,
        fSelectedInterestMap,
        fFlowModel,
      ];

  ProfileCreationFlowState copyWith(
      {ProfileCreationFlowEnum? fProfileCreationStage,
      ProfileCreationFlowModel? fFlowModel,
      Map<String, List<String>>? fSelectedInterestMap,
      double? fSearchRadius,
      String? fLocationMeasure}) {
    return ProfileCreationFlowState(
      fSelectedInterestMap: fSelectedInterestMap ?? this.fSelectedInterestMap,
      fFlowModel: fFlowModel ?? this.fFlowModel,
      fProfileCreationStage:
          fProfileCreationStage ?? this.fProfileCreationStage,
    );
  }
}
