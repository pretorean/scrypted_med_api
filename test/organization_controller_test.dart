import 'harness/app.dart';

Future main() async {
  final harness = Harness()..install();

  tearDown(() async {
    await harness.resetData();
  });

  test("GET /org", () async {
    expectResponse(await createOrganization(harness, 'org1'), 200);
    expectResponse(await createOrganization(harness, 'org2'), 200);

    final response = await harness.agent.get("/api/org");
    expect(response, hasResponse(200, body: hasLength(2)));
  });

  test("POST /org", () async {
    final response = await createOrganization(harness, 'OrgName');
    expect(
        response,
        hasResponse(200,
            body: partial({
              "id": isNotNull,
              "name": "OrgName",
              "createdAt": isTimestamp
            })));
  });

  test("GET /org/id", () async {
    expectResponse(await createOrganization(harness, 'org1'), 200);

    final response = await harness.agent.get("/api/org/1");

    expect(
        response,
        hasResponse(200,
            body: partial(
                {"id": isNotNull, "name": "org1", "createdAt": isTimestamp})));
  });

  test("PUT /org/id", () async {
    expectResponse(await createOrganization(harness, 'org1'), 200);

    final response = await harness.agent
        .put("/api/org/1", body: {"name": 'org2', 'fullName': 'fullOrgName'});
    expect(
        response,
        hasResponse(200,
            body: partial({
              "id": isNotNull,
              "name": "org2",
              'fullName': 'fullOrgName',
              "createdAt": isTimestamp
            })));
  });

  test("DELETE /org/id", () async {
    expectResponse(await createOrganization(harness, 'org1'), 200);
    expectResponse(await createOrganization(harness, 'org2'), 200);

    var response = await harness.agent.get("/api/org");
    expect(response, hasResponse(200, body: hasLength(2)));

    expectResponse(await harness.agent.delete("/api/org/1"), 200);

    response = await harness.agent.get("/api/org");
    expect(response, hasResponse(200, body: hasLength(1)));
  });

//  test("GET /model/:id returns previously created object", () async {
//    var response = await harness.agent.post("/model", body: {"name": "Bob"});
//
//    final createdObject = response.body.as();
//    response =
//        await harness.agent.request("/model/${createdObject["id"]}").get();
//    expect(
//        response,
//        hasResponse(200, body: {
//          "id": createdObject["id"],
//          "name": createdObject["name"],
//          "createdAt": createdObject["createdAt"]
//        }));
//  });
}

Future<TestResponse> createOrganization(Harness harness, String name) async {
  final response = await harness.agent.post("/api/org", body: {"name": name});
  return response;
}
