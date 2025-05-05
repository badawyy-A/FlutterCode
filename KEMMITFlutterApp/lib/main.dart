import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:morshd/core/caching/app_shared_pref.dart';
import 'package:morshd/core/caching/app_shared_pref_key.dart';
import 'package:morshd/features/home/api/const.dart';
import 'package:morshd/morshd.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPref.initSharedPref();

  try {
    Gemini.init(
      apiKey: GEMINI_API_KEY,
    );
    print('Gemini initialized successfully.');
  } catch (e) {
    print('Failed to initialize Gemini: $e');
  }

  userId = await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userId) ?? '';
  userName = await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userName) ?? '';

  print('userId: $userId');
  print('userName: $userName');

  runZonedGuarded(
        () => runApp(const ProviderScope(child: MorshdApp())),
        (error, stackTrace) {
      print('Caught an error: $error');
    },
  );
}

/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:morshd/core/caching/app_shared_pref.dart';
import 'package:morshd/core/caching/app_shared_pref_key.dart';
import 'package:morshd/features/home/api/const.dart';
import 'package:morshd/morshd.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runZonedGuarded(() async {
    // ✅ Move this inside runZonedGuarded()
    WidgetsFlutterBinding.ensureInitialized();

    await AppSharedPref.initSharedPref();

    try {
      Gemini.init(apiKey: GEMINI_API_KEY);
      debugPrint('Gemini initialized successfully.');
    } catch (e) {
      debugPrint('Failed to initialize Gemini: $e');
    }

    userId = await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userId) ?? '';
    userName = await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userName) ?? '';

    debugPrint('userId: $userId');
    debugPrint('userName: $userName');

    runApp(const ProviderScope(child: MorshdApp()));
  }, (error, stackTrace) {
    debugPrint('Caught an error: $error');
  });
}
*/