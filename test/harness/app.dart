import 'package:scrypted_med_api/scrypted_med_api.dart';
import 'package:aqueduct_test/aqueduct_test.dart';

export 'package:scrypted_med_api/scrypted_med_api.dart';
export 'package:aqueduct_test/aqueduct_test.dart';
export 'package:test/test.dart';
export 'package:aqueduct/aqueduct.dart';

/// A testing harness for scrypted_med_api.
///
/// A harness for testing an aqueduct application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("GET /path returns 200", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///
class Harness extends TestHarness<ScryptedMedApiChannel> with TestHarnessORMMixin {
  @override
  ManagedContext get context => channel.context;

  @override
  Future onSetUp() async {
    await resetData();
  }

  @override
  Future onTearDown() async {

  }

  @override
  Future seed() async {
    // restore any static data. called by resetData.
  }
}