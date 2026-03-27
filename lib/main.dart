import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool supabaseError = false;

  try {
    await dotenv.load(fileName: ".env");

    final url = dotenv.env['SUPABASE_URL'] ?? '';
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

    if (url.isEmpty || url.contains('placeholder') || anonKey.isEmpty) {
      debugPrint('SUPABASE CONFIG ERROR: Please provide real keys in .env');
      supabaseError = true;
    } else {
      await Supabase.initialize(url: url, anonKey: anonKey);
    }
  } catch (e) {
    debugPrint('INITIALIZATION ERROR: $e');
    supabaseError = true;
  }

  // Remote sync is now handled via syncServiceProvider in the UI

  runApp(
    ProviderScope(
      child: SpecialtyTrackerApp(initializationError: supabaseError),
    ),
  );
}

class SpecialtyTrackerApp extends ConsumerWidget {
  final bool initializationError;
  const SpecialtyTrackerApp({super.key, this.initializationError = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (initializationError) {
      return MaterialApp(
        theme: AppTheme.darkTheme,
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.orange),
                  const SizedBox(height: 24),
                  const Text(
                    'Configuration Required',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Please add your real SUPABASE_URL and SUPABASE_ANON_KEY to the .env file and rebuild the app.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Try Offline Mode (Experimental)'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Specialty Tracker',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
