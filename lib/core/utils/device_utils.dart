import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Utility class for device information and responsive design
class DeviceUtils {
  factory DeviceUtils() => _instance;
  DeviceUtils._internal();
  static final DeviceUtils _instance = DeviceUtils._internal();

  /// Check if device is mobile
  bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  }

  /// Check if device is tablet
  bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.mobileBreakpoint &&
        width < AppConstants.tabletBreakpoint;
  }

  /// Check if device is desktop
  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;
  }

  /// Get responsive font size
  double getResponsiveFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  /// Get responsive padding
  EdgeInsets getResponsivePadding(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  /// Get responsive margin
  EdgeInsets getResponsiveMargin(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  /// Get screen size category
  ScreenSize getScreenSizeCategory(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppConstants.mobileBreakpoint) {
      return ScreenSize.mobile;
    } else if (width < AppConstants.tabletBreakpoint) {
      return ScreenSize.tablet;
    } else {
      return ScreenSize.desktop;
    }
  }

  /// Get safe area padding
  EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get screen dimensions
  Size getScreenDimensions(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Get screen orientation
  Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// Check if device has notch
  bool hasNotch(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return padding.top > 20 || padding.bottom > 0;
  }

  /// Get status bar height
  double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// Get bottom safe area height
  double getBottomSafeAreaHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
}

/// Screen size enumeration
enum ScreenSize { mobile, tablet, desktop }

/// Global device utils instance
final deviceUtils = DeviceUtils();
