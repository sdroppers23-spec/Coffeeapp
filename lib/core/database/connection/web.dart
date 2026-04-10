import 'package:drift/drift.dart';

// For now, web support is just a stub to allow compilation.
// To fully support web, we would need wasm setup.
QueryExecutor openConnection() {
  return LazyDatabase(() async {
    return throw UnsupportedError(
      'Web database not yet configured. Please run on Windows/Mobile.',
    );
  });
}
