class AppConst {
  AppConst._();
  static const String appName = 'Detect It';
  static const double defaultPadding = 16.0;
  static const String apiBaseUrl = 'http://18.175.227.101/';
  static const int timeOutRequest = 30;
  static const String placeholderImageUrl =
      'https://api.dicebear.com/9.x/adventurer/png?seed=Sarah';
}

class RouteNames {
  RouteNames._();

  static const String splashScreen = '/';
  static const String homeScreen = '/home';
  static const String settingsScreen = '/settings';
  static const String profileScreen = '/profile';
  static const String welcomeScreen = '/welcome';
  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
}

enum DbCollections {
  users('users'),
  diseases('diseases'),
  scans('scans');

  const DbCollections(this.value);
  final String value;
}
