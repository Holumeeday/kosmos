///This holds value for the units of measure in the location screen
enum UnitOfLocationMeasurementEnum {
  miles('miles'),
  kilometres('kilometres');

  //Name of enum
  final String name;

  const UnitOfLocationMeasurementEnum(this.name);

  static UnitOfLocationMeasurementEnum fromString(String value) {
    return UnitOfLocationMeasurementEnum.values.singleWhere(
      (element) => element.name == value,
    );
  }
}
