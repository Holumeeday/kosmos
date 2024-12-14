import 'dart:collection';

import 'package:playkosmos_v3/enums/enums.dart';

///List extensions
extension ListBookingsExtension on List {
  ///Ranking the top in a list for post reaction
  ///
  ///Use a list of reaction int
  Map<ReactionIconTypeEnum, int> rankReaction() {
    var rankMap = <ReactionIconTypeEnum, int>{};

    for (ReactionIconTypeEnum element in this) {
      rankMap.update(
        element,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }
    var sortByValue = SplayTreeMap<ReactionIconTypeEnum, int>.from(
        rankMap, (key1, key2) => rankMap[key2]!.compareTo(rankMap[key1]!));
    return sortByValue;
  }
}

/// Extension for common list operations across the app
extension ListExtension<E> on List<E> {
  /// Searches a list of [E] with the bool [test] and if not true, calls [orElse]
  /// and if [orElse] is not declared, returns null
  E? search(bool Function(E element) test, {E? Function()? orElse}) {
    for (E element in this) {
      if (test(element)) return element;
    }
    if (orElse != null) return orElse();
    return null;
  }

  /// To add an element to a list. Used when the list is being listened to by
  /// the select function
  List<E> playkosmosAdd(E element) {
    final newList = [...this];
    newList.add(element);
    return newList;
  }

  /// To add an element to a list. Used when the list is being listened to by
  /// the select function
  List<E> playkosmosInsertAt(int index, E element) {
    final newList = [...this];
    newList.insert(index, element);
    return newList;
  }

  /// To add multiple elements to a list. Used when the list is being listened
  /// to by the select function
  List<E> playkosmosAddAll(Iterable<E> elements) {
    final newList = [...this, ...elements];
    return newList;
  }

  /// To remove an element from a list at a particular index. Used when the
  /// list is being listened to by the select function
  List<E> playkosmosRemoveAt(int index) {
    final newList = [...this];
    newList.removeAt(index);
    return newList;
  }

  /// To remove an element from a list at a particular index. Used when the
  /// list is being listened to by the select function
  List<E> playkosmosRemoveWhere(bool Function(E item) test) {
    final newList = [...this];
    newList.removeWhere(test);
    return newList;
  }

  /// To update an element in a list. Used when the list is being listened to by
  /// the select function
  List<E> playkosmosUpdate(int index, E value) {
    final newList = playkosmosRemoveAt(index);
    newList.insert(index, value);
    return newList;
  }

  /// To find the index of an item based on a test. This returns null if the
  /// item is no longer in the list
  int? playkosmosIndexWhere(bool Function(E item) test) {
    final int index = indexWhere(test);
    return index < 0 ? null : index;
  }
}
