class EnvironmentConfig {
  static const String flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'dev',
  );

  static bool get isDev => flavor == 'dev';
  static bool get isRelease => flavor == 'release';

  // Feature flags
  static bool get showBeanScanner => !isRelease;
  static bool get showLatteArt => !isRelease;
  static bool get showSphere => !isRelease;
  static bool get showManualSync => !isRelease;
  static bool get showAdminConsole => isDev;
}
