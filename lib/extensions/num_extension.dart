import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:playkosmos_v3/utils/utils.dart';

extension NumExtension on num {
  AppLocalizations get _loc => GetContext.loc;

  /// Formats numbers less than 10000 as #,### and the rest are given the
  /// compact form
  String formatProfileStats() {
    if (this < 10000) {
      return formatThousand();
    } else {
      return formatNumToCompact();
    }
  }

  /// Formats numbers  as #,###
  String formatThousand() {
    final formatter = NumberFormat(
      '#,###',
      _loc.localeName,
    );
    return formatter.format(this);
  }

  /// Formats fee / price to a double decimal place only when it has decimal
  /// numbers greater than 0
  String formatFee() {
    final formatter = NumberFormat(
      '#,###.##',
      _loc.localeName,
    );
    return formatter.format(this);
  }

  ///To format an int to compact form i.e from 200000 to 200k
  String formatNumToCompact() => NumberFormat.compact(
        locale: _loc.localeName,
      ).format(this);

  /// To format a num to currency form i.e from 200000 to $200,000.00
  String formatNumToCurrency(
    String currency, [
    int? decimalDigits,
  ]) =>
      NumberFormat.currency(
        locale: _loc.localeName,
        symbol: currency,
        decimalDigits: decimalDigits,
      ).format(this);

  /// To format a number to the currency form. This uses the euro for the currency
  String formatNumToDefaultCurrency([int? decimalDigits]) =>
      NumberFormat.currency(
        locale: _loc.localeName,
        symbol: '£',
        decimalDigits: decimalDigits,
      ).format(this);
}
