import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  tearDown(() async {
    await harness.resetData();
  });

  test("GET /org/1/serv", () async {
    expectResponse(await createOrganization(harness, 'org1'), 200);

    expectResponse(await createService(harness, 'serv1'), 200);
    expectResponse(await createService(harness, 'serv2'), 200);

    final response = await harness.agent.get("/api/org/1/serv");
    expect(response, hasResponse(200, body: hasLength(2)));
  });

  test("POST /org/1/serv", () async {
    expectResponse(await createOrganization(harness, 'org1'), 200);

    final response = await createService(harness, 'OrgName');
    expect(
        response,
        hasResponse(200,
            body: partial({
              "id": isNotNull,
              "name": "OrgName",
              "createdAt": isTimestamp
            })));
  });

  test("GET /org/1/serv/id", () async {
    expectResponse(await createOrganization(harness, 'org1'), 200);
    expectResponse(await createService(harness, 'serv1'), 200);

    final response = await harness.agent.get("/api/org/1/serv/1");

    expect(
        response,
        hasResponse(200,
            body: partial(
                {"id": isNotNull, "name": "serv1", "createdAt": isTimestamp})));
  });

  test("PUT /org/id", () async {
    expectResponse(await createOrganization(harness, 'org1'), 200);

    expectResponse(await createService(harness, 'serv1'), 200);

    final response = await harness.agent
        .put("/api/org/1/serv/1", body: {"name": 'org2', 'price': 111.11});
    expect(
        response,
        hasResponse(200,
            body: partial({
              "id": isNotNull,
              "name": "org2",
              'price': 111.11,
              "createdAt": isTimestamp
            })));
  });

  test("DELETE /org/id", () async {
    expectResponse(await createOrganization(harness, 'org1'), 200);

    expectResponse(await createService(harness, 'serv1'), 200);
    expectResponse(await createService(harness, 'serv2'), 200);

    var response = await harness.agent.get("/api/org/1/serv");
    expect(response, hasResponse(200, body: hasLength(2)));

    expectResponse(await harness.agent.delete("/api/org/1/serv/1"), 200);

    response = await harness.agent.get("/api/org/1/serv");
    expect(response, hasResponse(200, body: hasLength(1)));
  });
}

Future<TestResponse> createService(Harness harness, String name) async {
  final response =
      await harness.agent.post('/api/org/1/serv', body: {'name': name});
  return response;
}

Future<TestResponse> createOrganization(Harness harness, String name) async {
  final response = await harness.agent.post("/api/org", body: {"name": name});
  return response;
}
