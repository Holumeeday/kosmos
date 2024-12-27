import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/constants/buddies_list.dart';
import 'package:playkosmos_v3/models/buddies_model.dart';

part 'buddy_connections_state.dart';

/// Cubit for managing buddy connections and their filtered states.
/// 
/// This cubit handles the logic for filtering and managing the following, followers, 
/// and buddies lists. It also toggles the "show all" state for each category.
///
/// @author: Chidera Chijama
class BuddyConnectionsCubit extends Cubit<BuddyConnectionsState> {
  /// Initializes the cubit with filtered lists of buddies based on their connection types.
  ///
/// - `fFollowing`: Following of the current buddy that are not of connection type `'buddy'` but are being followed by the user.
///
/// - `fFollowingListBuddies`: Following of the current buddy that are of connection type `'buddy'` and are being followed by the user.
///
/// - `fFollowingShowAll`: Indicates whether to show all following buddies or limit the list to a subset.
///
/// - `fFollowers`: Followers of the current buddy that are not of connection type `'buddy'` but are following the user.
///
/// - `fFollowersListBuddies`: Followers of the current buddy that are of connection type `'buddy'` and are following the user.
///
/// - `fFollowersShowAll`: Indicates whether to show all followers or limit the list to a subset.
///
/// - `fBuddies`: Buddies of the current buddy that are not of connection type `'buddy'` with the user.
///
/// - `fBuddiesListBuddies`: Buddies of the current buddy that are of connection type `'buddy'` with the user.
///
/// - `fBuddiesShowAll`: Indicates whether to show all buddies or limit the list to a subset.

  BuddyConnectionsCubit()
      : super(BuddyConnectionsState(
          fFollowing: fullBuddiesList
              .where((buddy) => buddy.connectionType != 'buddy')
              .toList(),
          fFollowingListBuddies: fullBuddiesList
              .where((buddy) => buddy.connectionType == 'buddy')
              .toList(),
          fFollowingShowAll: false,
          fFollowers: fullBuddiesList
              .where((buddy) => buddy.connectionType != 'buddy')
              .toList(),
          fFollowersListBuddies: fullBuddiesList
              .where((buddy) => buddy.connectionType == 'buddy')
              .toList(),
          fFollowersShowAll: false,
          fBuddies: fullBuddiesList
              .where((buddy) => buddy.connectionType != 'buddy')
              .toList(),
          fBuddiesListBuddies: fullBuddiesList
              .where((buddy) => buddy.connectionType == 'buddy')
              .toList(),
          fBuddiesShowAll: false,
        ));

  /// Toggles the "Show All" state for the following list.
  void toggleFollowingShowAll() {
    emit(state.copyWith(
      fFollowingShowAll: !state.fFollowingShowAll,
    ));
  }

  /// Toggles the "Show All" state for the followers list.
  void toggleFollowersShowAll() {
    emit(state.copyWith(
      fFollowersShowAll: !state.fFollowersShowAll,
    ));
  }

  /// Toggles the "Show All" state for the buddies list.
  void toggleBuddiesShowAll() {
    emit(state.copyWith(
      fBuddiesShowAll: !state.fBuddiesShowAll,
    ));
  }
}
