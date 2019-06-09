import 'package:scrypted_med_api/model/organization.dart';
import 'package:scrypted_med_api/repository/organization_repository.dart';

import '../scrypted_med_api.dart';

class OrganizationController extends ResourceController {
  OrganizationController(this.context) {
    repository = OrganizationRepository(context);
  }

  final ManagedContext context;
  OrganizationRepository repository;

  @Operation.get()
  Future<Response> getAll(
      {@Bind.query('q') String query, @Bind.query('r') int region}) async {
    final list = await repository.getAllCompanyList(20, query, region);
    return Response.ok(list);
  }

  @Operation.get("orgId")
  Future<Response> getItemById(@Bind.path("orgId") int orgId) async {
    final company = await repository.getCompanyById(orgId);

    if (company == null) {
      return Response.notFound();
    }

    return Response.ok(company);
  }

  @Operation.post()
  Future<Response> createItem(@Bind.body() Organization org) async {
    final newOrg = await repository.createOrganization(org);
    return Response.ok(newOrg);
  }

  @Operation.put("orgId")
  Future<Response> updateItem(
      @Bind.path("orgId") int orgId, @Bind.body() Organization org) async {
    final tmpOrg = await repository.setOrganization(orgId, org);
    if (tmpOrg == null) {
      return Response.notFound();
    } else {
      return Response.ok(tmpOrg);
    }
  }

  @Operation.delete("orgId")
  Future<Response> deleteItem(@Bind.path("orgId") int orgId) async {
    final count = await repository.deleteOrganization(orgId);
    if (count == 0) {
      return Response.notFound();
    } else {
      return Response.ok({"deleted": "$count"});
    }
  }
}
