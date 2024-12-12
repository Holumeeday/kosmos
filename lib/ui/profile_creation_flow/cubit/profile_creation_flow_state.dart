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

  const ProfileCreationFlowState({
    required this.fProfileCreationStage,
    required this.fFlowModel,
    required this.fSelectedInterestMap,
    required this.fInterestGroupList,
  });

  @override
  List<Object> get props => [
        fProfileCreationStage,
        fInterestGroupList,
        fSelectedInterestMap,
        fFlowModel,
      ];

  ProfileCreationFlowState copyWith({
    ProfileCreationFlowEnum? fProfileCreationStage,
    ProfileCreationFlowModel? fFlowModel,
    List<ActivityInterestGroups>? fInterestGroupList,
    Map<String, List<String>>? fSelectedInterestMap,
  }) {
    return ProfileCreationFlowState(
      fSelectedInterestMap: fSelectedInterestMap ?? this.fSelectedInterestMap,
      fInterestGroupList: fInterestGroupList ?? this.fInterestGroupList,
      fFlowModel: fFlowModel ?? this.fFlowModel,
      fProfileCreationStage:
          fProfileCreationStage ?? this.fProfileCreationStage,
    );
  }
}
