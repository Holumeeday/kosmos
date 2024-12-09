/// Enum used for selecting between whatsapp and sms otp method
enum PhoneOtpMethodEnum {
  whatsapp('whatsapp'),
  sms('sms');

  final String name;
  const PhoneOtpMethodEnum(this.name);
}
