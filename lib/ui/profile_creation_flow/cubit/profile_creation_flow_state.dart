part of 'profile_creation_flow_cubit.dart';

class ProfileCreationFlowState extends Equatable {
  /// The current profile setup stage
  final ProfileCreationFlowEnum fProfileCreationStage;

  /// The second step flow model
  final ProfileCreationFlowModel fFlowModel;

  /// Activities interest group list
  final List<ActivityInterestGroups> fInterestGroupList;

  /// Selected interest group
  final Map<String, List<String>> fSelectedInterestMap;

    /// Selected dist group
  final double fSearchRadius;

    /// Selected interest group
  final String fLocationMeasure;

  const ProfileCreationFlowState( {
    required this.fProfileCreationStage,
    required this.fFlowModel,
    required this.fSelectedInterestMap,
    required this.fInterestGroupList,
    required this.fSearchRadius, required this.fLocationMeasure,
  });

  @override
  List<Object> get props => [
        fProfileCreationStage,
        fInterestGroupList,
        fSelectedInterestMap,
        fFlowModel,
        fSearchRadius,
        fLocationMeasure
      ];

  ProfileCreationFlowState copyWith({
    ProfileCreationFlowEnum? fProfileCreationStage,
    ProfileCreationFlowModel? fFlowModel,
    List<ActivityInterestGroups>? fInterestGroupList,
    Map<String, List<String>>? fSelectedInterestMap,
    double? fSearchRadius,
    String? fLocationMeasure
  }) {
    return ProfileCreationFlowState(
      fSelectedInterestMap: fSelectedInterestMap ?? this.fSelectedInterestMap,
      fInterestGroupList: fInterestGroupList ?? this.fInterestGroupList,
      fFlowModel: fFlowModel ?? this.fFlowModel,
      fProfileCreationStage:
          fProfileCreationStage ?? this.fProfileCreationStage,
      fSearchRadius: fSearchRadius ?? this.fSearchRadius,
      fLocationMeasure:fLocationMeasure ?? this.fLocationMeasure
      
    );
  }
}
