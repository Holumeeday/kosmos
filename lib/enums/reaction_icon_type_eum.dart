/// The different types of reactions
/// Reaction can be none
enum ReactionIconTypeEnum {
  like('like'),
  clap('clap'),
  heart('heart'),
  party('party'),
  dislike('dislike'),
  sad('sad'),
  angry('angry'),
  cry('cry'),
  shock('shock'),
  laugh('laugh');

  final String name;

  const ReactionIconTypeEnum(this.name);

  static ReactionIconTypeEnum fromString(String value) {
    return ReactionIconTypeEnum.values.singleWhere(
        (element) => element.name.toLowerCase() == value.toLowerCase(),
        orElse: () => ReactionIconTypeEnum.like);
  }
}
