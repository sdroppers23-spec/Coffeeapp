// ignore_for_file: avoid_print
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:drift/native.dart';
import 'package:specialty_tracker/core/database/app_database.dart';
import 'package:specialty_tracker/core/database/coffee_data_seed.dart';
import 'package:specialty_tracker/core/database/sync_service.dart';

void main() {
  test('Manual Upload to Supabase', () async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // 1. Load .env
    await dotenv.load(fileName: '.env');
    final url = dotenv.env['SUPABASE_URL']!;
    final anonKey = dotenv.env['SUPABASE_ANON_KEY']!;

    print('Initializing Supabase with URL: $url');
    await Supabase.initialize(url: url, anonKey: anonKey);

    // 2. Init In-memory DB
    print('Initializing In-memory Database...');
    final db = AppDatabase(NativeDatabase.memory());
    await db.customStatement('PRAGMA foreign_keys = ON');

    // 3. Local Seed
    print('Seeding Local Data (13 languages)...');
    await CoffeeDataSeed(db).seedAll();

    // 4. Push to Cloud
    print('Pushing to Supabase...');
    final sync = SyncService(db, Supabase.instance.client);
    await sync.pushLocalToCloud(onProgress: (msg, prog) => print('PUSH: $msg ($prog)'));

    print('DONE: Data uploaded successfully!');
  });
}
