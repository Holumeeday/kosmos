/// Represents the connection type of individuals within a particular search radius.
///
/// @author: Chijama Chidera
enum ConnectionTypeEnum {
  /// Someone who is a confirmed buddy of the user.
  buddy,

  /// Someone who is following the user.
  followingUser,

  /// Someone the user is following.
  userFollowing,

  /// Someone with no prior connection to the user.
  stranger
}
