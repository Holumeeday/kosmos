import 'package:playkosmos_v3/data/data_source/interfaces/remote_api.dart';
import 'package:playkosmos_v3/models/generic_respose_model.dart';

class BuddiesRemoteApiRepository {
  /// The remote api to be used nodejs/java
  final RemoteApi _remoteApi;

  const BuddiesRemoteApiRepository({
    required RemoteApi remoteApi,
  }) : _remoteApi = remoteApi;

  // Example method to fetch buddies data
  Future<GenericResponse> fetchBuddies() async {
    try {
      int limit = 10;
      int page = 1;
      final res = await _remoteApi.get('buddies?limit=$limit&page=$page',
          // queryParameters: {"limit": 10, "page": 1}
          );
      return GenericResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (_) {
      rethrow;
    }
  }
}
