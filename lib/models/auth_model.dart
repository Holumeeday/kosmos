/*
The model used by the auth service for routing
@author: Godwin Mathias
 */
class AuthModel {
  /// If the app has been initialized i.e opened for the first time
  final bool isInitialized;

  /// The onboarding process is done
  final bool isOnboarded;

  /// If the user is created
  final bool isLoggedIn;

  /// If the user is otp verified
  final bool isVerified;

  /// if the user has seen the pic and bio screen
  final bool hasCompletedStep2;

  const AuthModel({
    required this.isInitialized,
    required this.isOnboarded,
    required this.isLoggedIn,
    required this.isVerified,
    required this.hasCompletedStep2,
  });

  /// Create a new AuthModel instance with updated properties
  AuthModel copyWith({
    bool? isInitialized,
    bool? isOnboarded,
    bool? isLoggedIn,
    bool? isVerified,
    bool? hasCompletedStep2,
  }) {
    return AuthModel(
      isInitialized: isInitialized ?? this.isInitialized,
      isOnboarded: isOnboarded ?? this.isOnboarded,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isVerified: isVerified ?? this.isVerified,
      hasCompletedStep2: hasCompletedStep2 ?? this.hasCompletedStep2,
    );
  }

  /// Create an AuthModel instance from a JSON map
  factory AuthModel.fromJson(Map<dynamic, dynamic>? json) {
    if (json == null) {
      return AuthModel.empty();
    }
    return AuthModel(
      isInitialized: json['isInitialized'] ?? false,
      isOnboarded: json['isOnboarded'] ?? false,
      isLoggedIn: json['isLoggedIn'] ?? false,
      isVerified: json['isVerified'] ?? false,
      hasCompletedStep2: json['hasCompletedStep2'] ?? false,
    );
  }

  /// Convert the AuthModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'isInitialized': isInitialized,
      'isOnboarded': isOnboarded,
      'isLoggedIn': isLoggedIn,
      'isVerified': isVerified,
      'hasCompletedStep2': hasCompletedStep2,
    };
  }

  /// Create an empty AuthModel instance
  factory AuthModel.empty() {
    return const AuthModel(
      isInitialized: false,
      isOnboarded: false,
      isLoggedIn: false,
      isVerified: false,
      hasCompletedStep2: false,
    );
  }

  /// if all the elements are true
  bool allTrue() {
    return isInitialized &&
        isOnboarded &&
        isLoggedIn &&
        isVerified &&
        hasCompletedStep2;
  }

  // toString method to print the AuthModel instance as a formatted string
  @override
  String toString() {
    return 'AuthModel: {\n'
        '  isInitialized: $isInitialized,\n'
        '  isOnboarded: $isOnboarded,\n'
        '  isLoggedIn: $isLoggedIn,\n'
        '  isVerified: $isVerified,\n'
        '  hasCompletedStep2: $hasCompletedStep2,\n'
        '}';
  }
}
