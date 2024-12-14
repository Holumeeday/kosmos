import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/constants/countries_list.dart';
import 'package:playkosmos_v3/extensions/extensions.dart';
import 'package:playkosmos_v3/models/country_model.dart';
import 'package:playkosmos_v3/utils/utils.dart';

/*
The custom phone field to pick a country
@author: Ugochukwu Umeh
 */
class CustomPhoneField extends StatefulWidget {
  /// The text controller
  final TextEditingController fTextController;

  /// When the country is changed
  final ValueChanged<CountryModel>? fOnCountryChanged;

  /// The validator
  final String? Function(String?) fValidator;

  /// The border radius which defaults to 10
  final double fBorderRadius;

  /// The initial code of the user which defaults to FI - Finland
  final String? fCountryInitialCode;

  /// To show a text form field meant to input international phone numbers. Has
  /// a picker to select the country [fCountryInitialCode] and initially
  /// defaults to finland. Has a border radius for the field which defaults to
  /// 10
  const CustomPhoneField({
    super.key,
    required this.fTextController,
    required this.fValidator,
    this.fCountryInitialCode = 'FI',
    this.fBorderRadius = 10,
    this.fOnCountryChanged,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  /// The country list
  late List<CountryModel> _dCountryList;

  /// The selected country
  late CountryModel _dSelectedCountry;

  @override
  void initState() {
    super.initState();

    /// To select the countries list
    _dCountryList = List.from(kCountriesList);

    /// To select the country
    _dSelectedCountry = _dCountryList.firstWhere(
      (country) => country.iso2 == widget.fCountryInitialCode,
      orElse: () => _dCountryList.first,
    );

    /// This is run because [_dSelectedCountry] has been changed
    widget.fOnCountryChanged?.call(_dSelectedCountry);
  }

  /// To show the country picker
  void showCountryPicker() async {
    await showDefaultModal(
      context,
      maxHeight: 80,
      child: CountryPickerSheet(
        fSelectedCountryName:
            _dSelectedCountry.localizedName(context.loc.localeName),
        fOnCountryTap: (country) {
          _dSelectedCountry = country;
          widget.fOnCountryChanged?.call(country);
        },
        fTrailing: (country) => Text(
          '(${country.phoneCodeAndPlus})',
          style: context.appTextTheme.buttonLarge?.copyWith(
            color: context.appColors.greyShade85Color,
          ),
        ),
      ),
    );

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      fTextController: widget.fTextController,
      fValidator: widget.fValidator,
      fLabelText: context.loc.phoneNumberHint,
      fInputAction: TextInputAction.done,
      fTextType: TextInputType.phone,
      fTextInputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      fContentPadding: EdgeInsets.zero,
      fPrefixIconConstraints: const BoxConstraints(
        minHeight: 56,
      ),
      fPrefixIcon: _SelectedCountryIcon(
        fSelectedCountry: _dSelectedCountry,
        fBorderRadius: widget.fBorderRadius,
        fOnTap: showCountryPicker,
      ),
    );
  }
}

/*
The prefix icon with the selected country for the text field
@author: Ugochukwu Umeh
 */
class _SelectedCountryIcon extends StatelessWidget {
  /// The selected country
  final CountryModel fSelectedCountry;

  /// The border radius
  final double fBorderRadius;

  /// When the icon is tapped
  final VoidCallback fOnTap;

  const _SelectedCountryIcon({
    required this.fSelectedCountry,
    required this.fBorderRadius,
    required this.fOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
      ),
      child: InkWell(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(fBorderRadius),
          bottomLeft: Radius.circular(fBorderRadius),
        ),
        onTap: fOnTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HSpace(8),
            //Flag
            Text(
              fSelectedCountry.flag,
              style: context.textTheme.titleMedium,
            ),
            const HSpace(6),

            // Dial code
            Text(
              fSelectedCountry.phoneCodeAndPlus,
              style: context.textTheme.titleMedium,
            ),
            const HSpace(4),

            // Drop down
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: context.colors.secondary,
              size: 21,
            ),
            const HSpace(4),
          ],
        ),
      ),
    );
  }
}
