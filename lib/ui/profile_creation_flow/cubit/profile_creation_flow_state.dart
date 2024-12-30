part of 'profile_creation_flow_cubit.dart';

enum ProfileCreationUploadNameStatus {
  initial,
  loading,
  success,
  failure,
}

enum ProfileCreationUploadOthersStatus {
  initial,
  loading,
  success,
  failure,
}

class ProfileCreationFlowState extends Equatable {
  /// The current profile setup stage
  final ProfileCreationFlowEnum fProfileCreationStage;

  /// The second step flow model
  final ProfileCreationFlowModel fFlowModel;

  /// Selected interest group
  final Map<String, List<String>> fSelectedInterestMap;

  /// Upload name and bio status
  final ProfileCreationUploadNameStatus uploadNameStatus;

  /// Upload other items status
  final ProfileCreationUploadOthersStatus uploadOthersStatus;

  /// The error message
  final String? errorMessage;

  /// The response data
  final GenericResponse? data;

  const ProfileCreationFlowState({
    required this.fProfileCreationStage,
    required this.fFlowModel,
    required this.fSelectedInterestMap,
    this.errorMessage,
    this.data,
    this.uploadNameStatus = ProfileCreationUploadNameStatus.initial,
    this.uploadOthersStatus = ProfileCreationUploadOthersStatus.initial,
  });

  @override
  List<Object?> get props => [
        fProfileCreationStage,
        fFlowModel,
        fSelectedInterestMap,
        uploadNameStatus,
        uploadOthersStatus,
        errorMessage,
        data,
      ];

  ProfileCreationFlowState copyWith({
    ProfileCreationFlowEnum? fProfileCreationStage,
    ProfileCreationFlowModel? fFlowModel,
    Map<String, List<String>>? fSelectedInterestMap,
    ProfileCreationUploadNameStatus? uploadNameStatus,
    ProfileCreationUploadOthersStatus? uploadOthersStatus,
    String? errorMessage,
    GenericResponse? data,
  }) {
    return ProfileCreationFlowState(
      fProfileCreationStage:
          fProfileCreationStage ?? this.fProfileCreationStage,
      fFlowModel: fFlowModel ?? this.fFlowModel,
      fSelectedInterestMap: fSelectedInterestMap ?? this.fSelectedInterestMap,
      uploadNameStatus: uploadNameStatus ?? this.uploadNameStatus,
      uploadOthersStatus: uploadOthersStatus ?? this.uploadOthersStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
