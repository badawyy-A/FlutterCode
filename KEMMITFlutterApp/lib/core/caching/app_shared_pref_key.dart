import 'package:morshd/core/caching/app_shared_pref.dart';

class AppSharedPrefKey {
  static const String userId = 'userId';
  static const String userName = 'userName';
    // ✅ Add this key for onboarding completion check
  static const String onboardingCompleted = 'onboarding_completed';
}

var userId = AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userId);
 var  userName = AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userName);
