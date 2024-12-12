/// Enum used for selecting between whatsapp and sms otp method
enum PhoneOtpMethodEnum {
  sms('SMS'),
  whatsapp('Whatsapp');

  final String name;
  const PhoneOtpMethodEnum(this.name);
}
