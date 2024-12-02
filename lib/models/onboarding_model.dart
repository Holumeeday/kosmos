enum OnboardingImageType {
  meetOnboardImage,
  createOnboardImage,
  earnOnboardImage,
  stayConnectedOnboardImage
}

class OnboardPageModel {
  ///The title of the onboarding current page
  final String title;

  ///The image
  final String image;

  ///The percent value
  final double percentValue;

  /// Image type
  final OnboardingImageType imageType;

  const OnboardPageModel({
    required this.title,
    required this.image,
    required this.percentValue,
    required this.imageType,
  });
}
