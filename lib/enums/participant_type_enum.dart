/// This holds the types of participants that can join an activity
enum ParticipantTypeEnum {
  playmate('Playmate'),
  team('Team'),
  venue('Venue'),
  store('Store');

  /// The name property of the enum
  final String name;

  const ParticipantTypeEnum(this.name);

  /// Converts a string to its corresponding ParticipantTypeEnum enum value
  static ParticipantTypeEnum? fromString(String? name) {
    if (name == null) return null;
    return ParticipantTypeEnum.values.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
    );
  }
}
