/// Enum used for selecting between whatsapp and sms otp method
enum PhoneOtpMethodEnum {
  whatsapp('Whatsapp'),
  sms('SMS');

  final String name;
  const PhoneOtpMethodEnum(this.name);
}
