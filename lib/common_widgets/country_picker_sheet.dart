import 'package:flutter/material.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/constants/countries_list.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/country_model.dart';

/*
To pick a country from the list of countries
@author: Ugochukwu Umeh
 */
class CountryPickerSheet extends StatefulWidget {
  /// The selected country
  final String? fSelectedCountryName;

  /// When the country is tapped
  final ValueChanged<CountryModel> fOnCountryTap;

  /// To customize the trailing widget
  final Widget Function(CountryModel)? fTrailing;

  const CountryPickerSheet({
    super.key,
    required this.fOnCountryTap,
    this.fSelectedCountryName,
    this.fTrailing,
  });

  @override
  State<CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<CountryPickerSheet> {
  /// Search editing controller
  late TextEditingController _fCountrySearchController;

  /// The list of countries
  List<CountryModel> _fCountries = [];

  /// The country
  String get _fSelectedCountry => widget.fSelectedCountryName ?? '';

  /// The list of countries to use for searching
  List<CountryModel> _dCountries = [];

  @override
  void initState() {
    super.initState();
    _fCountrySearchController = TextEditingController();
    _fCountrySearchController.addListener(searchCountries);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fCountries = rearrangeCountryList();
    _dCountries = List.from(_fCountries);
  }

  @override
  void dispose() {
    _fCountrySearchController.dispose();
    super.dispose();
  }

  /// To rearrange the country list
  List<CountryModel> rearrangeCountryList() {
    List<CountryModel> reorderedCountries = List.of(kCountriesList);
    for (CountryModel country in kCountriesList) {
      if (country.localizedName(context.loc.localeName).trim().toLowerCase() ==
          _fSelectedCountry.trim().toLowerCase()) {
        reorderedCountries.remove(country);
        reorderedCountries.insert(0, country);
      }
    }
    return reorderedCountries;
  }

  /// To search the countries
  void searchCountries() {
    String text = _fCountrySearchController.text.trim().toLowerCase();
    if (text.isEmpty) {
      _dCountries = List.from(_fCountries);
    } else {
      _dCountries = _fCountries.where((country) {
        final bool isInCountryName = country
            .localizedName(context.loc.localeName)
            .trim()
            .toLowerCase()
            .contains(text);
        final bool isInPhoneCode =
            country.phoneCode.trim().toLowerCase().contains(text);
        return isInCountryName || isInPhoneCode;
      }).toList();
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CSCPickerSheet(
      fHintText: context.loc.searchCountry,
      fTextController: _fCountrySearchController,
      fListIsNotEmpty: _dCountries.isNotEmpty,
      fShowList: Scrollbar(
        child: ListView.separated(
          itemCount: _dCountries.length,
          itemBuilder: (_, index) {
            final CountryModel country = _dCountries[index];
            return Material(
              child: RadioListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                value: _fSelectedCountry.trim().toLowerCase(),
                groupValue: country.name.trim().toLowerCase(),
                title: Row(
                  children: [
                    Text(
                      country.flag,
                    ),
                    const HSpace(8),
                    Flexible(
                      child: Text(
                        country.localizedName(context.loc.localeName),
                        style: context.appTextTheme.buttonLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const HSpace(4),
                    widget.fTrailing?.call(country) ?? const SizedBox.shrink(),
                  ],
                ),
                onChanged: (v) {
                  widget.fOnCountryTap(country);
                  Navigator.pop(context);
                },
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(
            height: 0,
          ),
        ),
      ),
    );
  }
}
