import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drift/native.dart';
import 'package:specialty_tracker/core/database/app_database.dart';
import 'package:specialty_tracker/core/database/sync_service.dart';
import 'package:drift/drift.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}
class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {}
class MockPostgrestFilterBuilder extends Mock implements PostgrestFilterBuilder<List<Map<String, dynamic>>> {}
class MockSupabaseAuth extends Mock implements GoTrueClient {}
class MockUser extends Mock implements User {}

void main() {
  late AppDatabase db;
  late MockSupabaseClient mockSupabase;
  late SyncService syncService;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    mockSupabase = MockSupabaseClient();
    syncService = SyncService(db, mockSupabase);
    
    final mockAuth = MockSupabaseAuth();
    final mockUser = MockUser();
    when(() => mockSupabase.auth).thenReturn(mockAuth);
    when(() => mockAuth.currentUser).thenReturn(mockUser);
    when(() => mockUser.id).thenReturn('user-123');
  });

  tearDown(() async {
    await db.close();
  });

  test('pullUserContent should NOT overwrite local unsynced coffee lots', () async {
    const lotId = 'test-lot-id';
    const initialSensory = '{"aroma": 5}';
    
    await db.into(db.coffeeLots).insert(CoffeeLotsCompanion.insert(
      id: lotId,
      userId: 'user-123',
      coffeeName: const Value('Test Coffee'),
      sensoryJson: const Value(initialSensory),
      isSynced: const Value(false),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    ));

    final queryBuilder = MockSupabaseQueryBuilder();
    final filterBuilder = MockPostgrestFilterBuilder();
    
    when(() => mockSupabase.from(any())).thenAnswer((_) => queryBuilder);
    when(() => queryBuilder.select()).thenAnswer((_) => filterBuilder);
    when(() => filterBuilder.eq(any(), any())).thenAnswer((_) => filterBuilder);
    
    final remoteLotsData = [
      {
        'id': lotId,
        'user_id': 'user-123',
        'coffee_name': 'Test Coffee',
        'sensory_json': {'aroma': 0}, 
        'is_synced': true,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      }
    ];

    // THE MAGIC MOCK FOR AWAITABLE MOCK
    when(() => filterBuilder.then(any(), onError: any(named: 'onError')))
        .thenAnswer((invocation) {
      final onValue = invocation.positionalArguments[0] as Function(List<Map<String, dynamic>>);
      return Future.value(onValue(remoteLotsData));
    });
    
    await syncService.pullUserContent();

    final localLot = await (db.select(db.coffeeLots)..where((t) => t.id.equals(lotId))).getSingle();
    
    // We expect this to fail (proving the bug)
    expect(localLot.sensoryJson, initialSensory);
  });
}
